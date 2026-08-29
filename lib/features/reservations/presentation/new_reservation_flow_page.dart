import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mh_salun/core/di/injection.dart';
import 'package:mh_salun/core/presentation/widgets/app_error_dialog.dart';
import 'package:mh_salun/core/router/app_router.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/features/reservations/bloc/book_reservation/book_reservation_bloc.dart';
import 'package:mh_salun/features/reservations/bloc/reservation_flow/reservation_flow_bloc.dart';
import 'package:mh_salun/features/reservations/model/reservation_step.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/booking_footer.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/review_step.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/select_barber_step.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/select_branch_step.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/select_datetime_step.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/select_services_step.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/step_progress.dart';

class NewReservationFlowPage extends StatelessWidget {
  const NewReservationFlowPage({super.key});

  @override
  Widget build(BuildContext context) {
    // One bloc per flow: leaving the page drops the selections with it.
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<ReservationFlowBloc>()),
        BlocProvider(create: (_) => getIt<BookReservationBloc>()),
      ],
      child: const _NewReservationFlowView(),
    );
  }
}

/// Owns only which step is on screen — every selection lives in
/// [ReservationFlowBloc].
class _NewReservationFlowView extends StatefulWidget {
  const _NewReservationFlowView();

  @override
  State<_NewReservationFlowView> createState() =>
      _NewReservationFlowViewState();
}

class _NewReservationFlowViewState extends State<_NewReservationFlowView> {
  ReservationStep _step = ReservationStep.branch;

  void _onBack() {
    final previous = _step.previous;
    if (previous == null) {
      Navigator.of(context).pop();
    } else {
      setState(() => _step = previous);
    }
  }

  void _goToStep(ReservationStep step) => setState(() => _step = step);

  void _onContinue(ReservationFlowState selection) {
    if (!selection.isAnswered(_step)) return;

    final next = _step.next;

    if (next != null) {
      setState(() => _step = next);
      return;
    }

    // Last step: the slot is all the booking call needs — it carries the
    // branch, barber and services resolved earlier in the flow.
    final slot = selection.slot;
    if (slot == null) return;
    context.read<BookReservationBloc>().add(BookReservationRequested(slot.id));
  }

  void _onBookingChanged(BuildContext context, BookReservationState state) {
    switch (state) {
      // The flow is done — replace it so back never returns into it.
      case BookReservationSuccess(:final reservation):
        context.pushReplacementNamed(
          AppRoutes.reservationSuccess,
          extra: reservation,
        );
      case BookReservationFailure(:final messageKey):
        AppErrorDialog.show(context, messageKey);
      case BookReservationInitial():
      case BookReservationLoading():
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookReservationBloc, BookReservationState>(
      listener: _onBookingChanged,
      child: BlocBuilder<ReservationFlowBloc, ReservationFlowState>(
        builder: (context, selection) {
          final bloc = context.read<ReservationFlowBloc>();

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
                child: StepProgress(
                  step: _step.index,
                  stepCount: ReservationStep.values.length,
                ),
              ),
            ),
            body: IndexedStack(
              index: _step.index,
              children: [
                SelectBranchStep(
                  selectedBranch: selection.branch,
                  onBranchSelected: (branch) =>
                      bloc.add(ReservationBranchSelected(branch)),
                ),
                SelectBarberStep(
                  selectedBarber: selection.barber,
                  onBarberSelected: (barber) =>
                      bloc.add(ReservationBarberSelected(barber)),
                ),
                SelectServicesStep(
                  barber: selection.barber,
                  selectedServices: selection.services,
                  onServiceToggled: (service) =>
                      bloc.add(ReservationServiceToggled(service)),
                ),
                const SelectDateTimeStep(),
                ReviewStep(
                  branch: selection.branch,
                  barber: selection.barber,
                  services: selection.services,
                  slot: selection.slot,
                  onEditStep: _goToStep,
                ),
              ],
            ),
            bottomNavigationBar:
                BlocBuilder<BookReservationBloc, BookReservationState>(
                  builder: (context, booking) => BookingFooter(
                    buttonLabel: _step.continueLabelKey.tr(),
                    canContinue: selection.isAnswered(_step),
                    onContinue: () => _onContinue(selection),
                    isLoading: booking is BookReservationLoading,
                  ),
                ),
          );
        },
      ),
    );
  }
}
