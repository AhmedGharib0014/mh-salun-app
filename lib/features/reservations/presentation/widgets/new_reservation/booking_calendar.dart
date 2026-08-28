import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/day_tile.dart';

/// Horizontal day strip for picking a booking day: a single scrollable row of
/// day tiles running from [firstDate] through [lastDate]. Each tile shows the
/// weekday over the day number; the chosen day is filled gold.
class BookingCalendar extends StatelessWidget {
  const BookingCalendar({
    super.key,
    required this.firstDate,
    required this.lastDate,
    required this.selectedDate,
    required this.onDateSelected,
  });

  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  int get _dayCount => lastDate.difference(firstDate).inDays + 1;

  @override
  Widget build(BuildContext context) {
    final locale = context.locale.toString();
    final weekday = DateFormat.E(locale);
    final month = DateFormat.MMM(locale);

    return SizedBox(
      height: 86,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.xs,
        ),
        itemCount: _dayCount,
        separatorBuilder: (_, index) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) {
          final date = DateTime(
            firstDate.year,
            firstDate.month,
            firstDate.day + index,
          );
          final selected =
              date.year == selectedDate.year &&
              date.month == selectedDate.month &&
              date.day == selectedDate.day;
          return DayTile(
            weekday: weekday.format(date),
            day: date.day.toString(),
            month: month.format(date),
            selected: selected,
            onTap: () => onDateSelected(date),
          );
        },
      ),
    );
  }
}
