import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/model/barber.dart';
import 'package:mh_salun/core/model/service.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/features/branches/model/branch.dart';
import 'package:mh_salun/features/reservations/model/time_slot.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/booking_footer.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/review_step.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/select_barber_step.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/select_branch_step.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/select_datetime_step.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/select_services_step.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/step_progress.dart';

class NewReservationFlowPage extends StatefulWidget {
  const NewReservationFlowPage({super.key});

  @override
  State<NewReservationFlowPage> createState() => _NewReservationFlowPageState();
}

class _NewReservationFlowPageState extends State<NewReservationFlowPage> {
  static const int _stepCount = 5;

  final Set<Service> _selectedServices = {};

  Branch? _selectedBranch;
  Barber? _selectedBarber;
  TimeSlot? _selectedSlot;
  int _step = 0;

  bool get _canContinue {
    switch (_step) {
      case 0:
        return _selectedBranch != null;
      case 1:
        return _selectedBarber != null;
      case 2:
        return _selectedServices.isNotEmpty;
      case 3:
        return _selectedSlot != null;
      default:
        return true; // Review step: every choice is already made.
    }
  }

  /// Label for the primary button, naming the selection type of the next step.
  String get _continueLabel {
    switch (_step) {
      case 0:
        return 'new_reservation_to_barber'.tr();
      case 1:
        return 'new_reservation_to_services'.tr();
      case 2:
        return 'new_reservation_to_datetime'.tr();
      case 3:
        return 'new_reservation_to_review'.tr();
      default:
        return 'new_reservation_book'.tr();
    }
  }

  void _onBack() {
    if (_step == 0) {
      Navigator.of(context).pop();
    } else {
      setState(() => _step -= 1);
    }
  }

  void _goToStep(int step) => setState(() => _step = step);

  void _onContinue() {
    if (!_canContinue) return;
    if (_step < _stepCount - 1) {
      setState(() => _step += 1);
    } else {
      // Final step: confirm the booking. Persisting it awaits the data layer.
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text('new_reservation_booked'.tr())));
      Navigator.of(context).pop();
    }
  }

  void _selectBranch(Branch branch) {
    setState(() {
      if (_selectedBranch?.id == branch.id) return;
      _selectedBranch = branch;
      _selectedBarber = null;
      _selectedServices.clear();
      _selectedSlot = null;
    });
  }

  void _selectBarber(Barber barber) => setState(() => _selectedBarber = barber);

  void _toggleService(Service service) {
    setState(() {
      if (!_selectedServices.remove(service)) _selectedServices.add(service);
    });
  }

  void _slotChanged(TimeSlot? slot) => setState(() => _selectedSlot = slot);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        toolbarHeight: 44,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _onBack,
        ),
        title: Text('new_reservation_title'.tr()),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(36),
          child: StepProgress(step: _step, stepCount: _stepCount),
        ),
      ),
      body: IndexedStack(
        index: _step,
        children: [
          SelectBranchStep(
            selectedBranch: _selectedBranch,
            onBranchSelected: _selectBranch,
          ),
          SelectBarberStep(
            selectedBarber: _selectedBarber,
            onBarberSelected: _selectBarber,
          ),
          SelectServicesStep(
            selectedServices: _selectedServices,
            onServiceToggled: _toggleService,
          ),
          // Keyed by branch so a different branch starts the calendar over.
          SelectDateTimeStep(
            key: ValueKey(_selectedBranch?.id),
            selectedSlot: _selectedSlot,
            onSlotChanged: _slotChanged,
          ),
          ReviewStep(
            branch: _selectedBranch,
            barber: _selectedBarber,
            services: _selectedServices,
            slot: _selectedSlot,
            onEditStep: _goToStep,
          ),
        ],
      ),
      bottomNavigationBar: BookingFooter(
        buttonLabel: _continueLabel,
        canContinue: _canContinue,
        onContinue: _onContinue,
      ),
    );
  }
}
