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
class SelectDateTimeStep extends StatelessWidget {
  const SelectDateTimeStep({
    super.key,
    required this.firstDate,
    required this.lastDate,
    required this.slots,
    required this.selectedDate,
    required this.selectedSlot,
    required this.onDateSelected,
    required this.onSlotSelected,
  });

  final DateTime firstDate;
  final DateTime lastDate;
  final List<TimeSlot> slots;
  final DateTime selectedDate;
  final TimeSlot? selectedSlot;
  final ValueChanged<DateTime> onDateSelected;
  final ValueChanged<TimeSlot> onSlotSelected;

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
          firstDate: firstDate,
          lastDate: lastDate,
          selectedDate: selectedDate,
          onDateSelected: onDateSelected,
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
            slots: slots,
            selectedSlot: selectedSlot,
            onSlotSelected: onSlotSelected,
          ),
        ),
      ],
    );
  }
}
