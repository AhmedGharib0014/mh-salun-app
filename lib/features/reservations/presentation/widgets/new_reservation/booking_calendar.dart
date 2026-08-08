import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';

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
          return _DayTile(
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

class _DayTile extends StatelessWidget {
  const _DayTile({
    required this.weekday,
    required this.day,
    required this.month,
    required this.selected,
    required this.onTap,
  });

  final String weekday;
  final String day;
  final String month;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color labelColor = selected
        ? AppColors.onPrimary.withValues(alpha: 0.75)
        : AppColors.onSurface;
    final Color dayColor = selected
        ? AppColors.onPrimary
        : AppColors.onBackground;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 58,
        decoration: BoxDecoration(
          gradient: selected
              ? const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.primaryLight, AppColors.primary],
                )
              : null,
          color: selected ? null : AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
          border: Border.all(
            color: selected
                ? Colors.transparent
                : AppColors.primary.withValues(alpha: 0.18),
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.35),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              weekday.toUpperCase(),
              style: AppTextStyles.caption.copyWith(
                color: labelColor,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              day,
              style: AppTextStyles.titleMedium.copyWith(
                color: dayColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              month.toUpperCase(),
              style: AppTextStyles.caption.copyWith(
                color: labelColor,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
