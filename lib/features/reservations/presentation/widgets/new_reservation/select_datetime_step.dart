import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';
import 'package:mh_salun/features/reservations/model/time_slot.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/booking_calendar.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/booking_step_header.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/time_slot_grid.dart';

/// Step 3 of the new-reservation flow: pick a day from the calendar (from
/// today onward, paging by month) then a single available time slot for it.
///
/// The bookable range and the picked day are the step's own business — the
/// flow never needs them, since [TimeSlot.time] already carries the full date.
/// Only the chosen slot travels back up, and it comes back null whenever the
/// day changes and the previous pick goes stale.
class SelectDateTimeStep extends StatefulWidget {
  const SelectDateTimeStep({
    super.key,
    required this.selectedSlot,
    required this.onSlotChanged,
  });

  final TimeSlot? selectedSlot;
  final ValueChanged<TimeSlot?> onSlotChanged;

  @override
  State<SelectDateTimeStep> createState() => _SelectDateTimeStepState();
}

class _SelectDateTimeStepState extends State<SelectDateTimeStep> {
  /// How far ahead the calendar lets the guest book.
  static const int _monthsAhead = 3;

  final DateTime _firstDate = _today();
  late final DateTime _lastDate = DateTime(
    _firstDate.year,
    _firstDate.month + _monthsAhead,
    _firstDate.day,
  );

  late DateTime _selectedDate = _firstDate;

  static DateTime _today() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  void _selectDate(DateTime date) {
    setState(() => _selectedDate = date);
    // Slots differ per day; drop the stale choice held by the flow.
    widget.onSlotChanged(null);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.md,
          ),
          child: BookingStepHeader(
            titleKey: 'new_reservation_datetime_title',
            subtitleKey: 'new_reservation_datetime_subtitle',
          ),
        ),
        BookingCalendar(
          firstDate: _firstDate,
          lastDate: _lastDate,
          selectedDate: _selectedDate,
          onDateSelected: _selectDate,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.sm,
          ),
          child: Text(
            'new_reservation_times_label'.tr(),
            style: AppTextStyles.titleMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: TimeSlotGrid(
            slots: TimeSlot.forDate(_selectedDate),
            selectedSlot: widget.selectedSlot,
            onSlotSelected: widget.onSlotChanged,
          ),
        ),
      ],
    );
  }
}
