import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';

/// One day in the booking day strip: weekday over day number over month.
class DayTile extends StatelessWidget {
  const DayTile({
    super.key,
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
