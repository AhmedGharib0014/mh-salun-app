import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/model/barber.dart';
import 'package:mh_salun/core/model/barbers_catalog.dart';
import 'package:mh_salun/core/model/service.dart';
import 'package:mh_salun/core/model/services_catalog.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';
import 'package:mh_salun/features/reservations/model/time_slot.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/review_step.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/select_barber_step.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/select_datetime_step.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/select_services_step.dart';

/// Multi-step flow the guest enters from the "+" button or a "start booking"
/// action. Step 1 picks a barber, step 2 picks one or more services, step 3
/// picks a date & time, and step 4 reviews the whole booking before confirming.
/// The selection is held here and passed down to each step.
class NewReservationFlowPage extends StatefulWidget {
  const NewReservationFlowPage({super.key});

  @override
  State<NewReservationFlowPage> createState() => _NewReservationFlowPageState();
}

class _NewReservationFlowPageState extends State<NewReservationFlowPage> {
  static const int _stepCount = 4;
  static const int _monthsAhead = 3;

  final List<Barber> _barbers = BarbersCatalog.all();
  final List<Service> _services = ServicesCatalog.all();
  final Set<Service> _selectedServices = {};
  final DateTime _firstDate = _today();
  late final DateTime _lastDate = DateTime(
    _firstDate.year,
    _firstDate.month + _monthsAhead,
    _firstDate.day,
  );

  Barber? _selectedBarber;
  late DateTime _selectedDate = _firstDate;
  TimeSlot? _selectedSlot;
  int _step = 0;

  bool get _canContinue {
    switch (_step) {
      case 0:
        return _selectedBarber != null;
      case 1:
        return _selectedServices.isNotEmpty;
      case 2:
        return _selectedSlot != null;
      default:
        return true; // Review step: every choice is already made.
    }
  }

  /// Label for the primary button, naming the selection type of the next step.
  String get _continueLabel {
    switch (_step) {
      case 0:
        return 'new_reservation_to_services'.tr();
      case 1:
        return 'new_reservation_to_datetime'.tr();
      case 2:
        return 'new_reservation_to_review'.tr();
      default:
        return 'new_reservation_book'.tr();
    }
  }

  /// Compact recap of the current step's selection, shown in the footer.
  /// Step 1: barber name. Step 2: services total. Step 3: date & time.
  /// Step 4 (review): the order total, ready to book.
  Widget _footerSummary() {
    switch (_step) {
      case 0:
        final name = _selectedBarber?.name;
        if (name == null) return const SizedBox.shrink();
        return Text(
          name,
          style: AppTextStyles.titleLarge,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        );
      case 1:
        if (_selectedServices.isEmpty) return const SizedBox.shrink();
        return Text(
          _formattedTotal(),
          style: AppTextStyles.titleLarge.copyWith(color: AppColors.primary),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        );
      case 2:
        final slot = _selectedSlot;
        if (slot == null) return const SizedBox.shrink();
        return Text(
          _formattedDateTime(slot.time),
          style: AppTextStyles.titleMedium,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        );
      default:
        return Text(
          _formattedTotal(),
          style: AppTextStyles.titleLarge.copyWith(color: AppColors.primary),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        );
    }
  }

  /// Sum of the selected services' prices, formatted with the active locale's
  /// digits. Prices are placeholder strings (e.g. "$25" / "٢٥$"), so we pull
  /// the numeric part out regardless of Western or Arabic-Indic digits.
  String _formattedTotal() {
    final total = _selectedServices.fold<int>(
      0,
      (sum, service) => sum + _priceValue(service.price),
    );
    final digits =
        NumberFormat.decimalPattern(context.locale.toString()).format(total);
    return '\$$digits';
  }

  static int _priceValue(String raw) {
    const arabicZero = 0x0660;
    final digits = StringBuffer();
    for (final rune in raw.runes) {
      if (rune >= 0x30 && rune <= 0x39) {
        digits.writeCharCode(rune);
      } else if (rune >= arabicZero && rune <= arabicZero + 9) {
        digits.writeCharCode(0x30 + (rune - arabicZero));
      }
    }
    return int.tryParse(digits.toString()) ?? 0;
  }

  String _formattedDateTime(DateTime time) {
    final locale = context.locale.toString();
    final date = DateFormat('EEE, d MMM', locale).format(time);
    final clock = DateFormat.jm(locale).format(time);
    return '$date · $clock';
  }

  static DateTime _today() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
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
        ..showSnackBar(
          SnackBar(content: Text('new_reservation_booked'.tr())),
        );
      Navigator.of(context).pop();
    }
  }

  void _selectBarber(Barber barber) =>
      setState(() => _selectedBarber = barber);

  void _toggleService(Service service) {
    setState(() {
      if (!_selectedServices.remove(service)) _selectedServices.add(service);
    });
  }

  void _selectDate(DateTime date) {
    setState(() {
      _selectedDate = date;
      _selectedSlot = null; // Slots differ per day; clear the stale choice.
    });
  }

  void _selectSlot(TimeSlot slot) => setState(() => _selectedSlot = slot);

  /// Builds the final recap. The review step is only reachable once every
  /// choice is made, but IndexedStack builds all children eagerly, so we guard
  /// against the not-yet-selected state before then.
  Widget _buildReviewStep() {
    final barber = _selectedBarber;
    final slot = _selectedSlot;
    if (barber == null || slot == null) return const SizedBox.shrink();
    return ReviewStep(
      barber: barber,
      services: _selectedServices.toList(),
      dateTimeLabel: _formattedDateTime(slot.time),
      totalLabel: _formattedTotal(),
      onEditStep: _goToStep,
    );
  }

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
          child: _StepProgress(step: _step, stepCount: _stepCount),
        ),
      ),
      body: IndexedStack(
        index: _step,
        children: [
          SelectBarberStep(
            barbers: _barbers,
            selectedBarber: _selectedBarber,
            onBarberSelected: _selectBarber,
          ),
          SelectServicesStep(
            services: _services,
            selectedServices: _selectedServices,
            onServiceToggled: _toggleService,
          ),
          SelectDateTimeStep(
            firstDate: _firstDate,
            lastDate: _lastDate,
            slots: TimeSlot.forDate(_selectedDate),
            selectedDate: _selectedDate,
            selectedSlot: _selectedSlot,
            onDateSelected: _selectDate,
            onSlotSelected: _selectSlot,
          ),
          _buildReviewStep(),
        ],
      ),
      bottomNavigationBar: _BookingFooter(
        summary: _footerSummary(),
        buttonLabel: _continueLabel,
        canContinue: _canContinue,
        onContinue: _onContinue,
      ),
    );
  }
}

/// Stepper under the app bar: numbered gold nodes joined by connector lines.
/// Completed steps collapse to a check, the active step gets a glowing ring,
/// and connectors fill in as the guest advances.
class _StepProgress extends StatelessWidget {
  const _StepProgress({required this.step, required this.stepCount});

  final int step;
  final int stepCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        0,
        AppSpacing.lg,
        AppSpacing.sm,
      ),
      child: Row(
        children: [
          for (var index = 0; index < stepCount; index++) ...[
            _StepNode(
              index: index,
              done: index < step,
              active: index == step,
            ),
            if (index < stepCount - 1)
              Expanded(child: _StepConnector(filled: index < step)),
          ],
        ],
      ),
    );
  }
}

class _StepNode extends StatelessWidget {
  const _StepNode({
    required this.index,
    required this.done,
    required this.active,
  });

  final int index;
  final bool done;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final bool reached = done || active;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: reached
            ? const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.primaryLight, AppColors.primary],
              )
            : null,
        color: reached ? null : AppColors.surfaceHigh,
        border: Border.all(
          color: reached
              ? AppColors.primaryLight
              : AppColors.primary.withValues(alpha: 0.25),
          width: active ? 2 : 1,
        ),
        boxShadow: active
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.45),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
      alignment: Alignment.center,
      child: done
          ? const Icon(
              Icons.check_rounded,
              size: AppSpacing.iconSm,
              color: AppColors.onPrimary,
            )
          : Text(
              '${index + 1}',
              style: AppTextStyles.label.copyWith(
                color: active
                    ? AppColors.onPrimary
                    : AppColors.primary.withValues(alpha: 0.6),
                fontWeight: FontWeight.w700,
              ),
            ),
    );
  }
}

class _StepConnector extends StatelessWidget {
  const _StepConnector({required this.filled});

  final bool filled;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 3,
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      decoration: BoxDecoration(
        color: filled
            ? AppColors.primary
            : AppColors.primary.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
      ),
    );
  }
}

/// Bottom bar carrying the primary continue button.
class _BookingFooter extends StatelessWidget {
  const _BookingFooter({
    required this.summary,
    required this.buttonLabel,
    required this.canContinue,
    required this.onContinue,
  });

  final Widget summary;
  final String buttonLabel;
  final bool canContinue;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.divider)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Expanded(child: summary),
              const SizedBox(width: AppSpacing.md),
              _ContinueButton(
                enabled: canContinue,
                label: buttonLabel,
                onTap: onContinue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Pill-shaped gradient CTA with a trailing arrow and a soft gold glow.
/// Hugs its label rather than filling the width, so it sits at the trailing
/// edge of the footer.
class _ContinueButton extends StatelessWidget {
  const _ContinueButton({
    required this.enabled,
    required this.label,
    required this.onTap,
  });

  final bool enabled;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.primaryLight, AppColors.primary],
          ),
          borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
          boxShadow: enabled
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.4),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: enabled ? onTap : null,
            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.md,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: AppTextStyles.buttonPrimary,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  const Icon(
                    Icons.arrow_forward_rounded,
                    size: AppSpacing.iconSm,
                    color: AppColors.onPrimary,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
