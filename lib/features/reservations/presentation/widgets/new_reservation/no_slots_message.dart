import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';

/// Shown when the day resolves to nothing bookable. The slots depend on the
/// branch, barber and services picked earlier as much as on the date, so the
/// hint points at both ways out: another day, or an earlier step changed.
class NoSlotsMessage extends StatelessWidget {
  const NoSlotsMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
      child: Column(
        children: [
          Icon(
            Icons.event_busy_rounded,
            size: AppSpacing.iconLg,
            color: AppColors.primary.withValues(alpha: 0.6),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'new_reservation_no_slots'.tr(),
            style: AppTextStyles.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'new_reservation_no_slots_hint'.tr(),
            style: AppTextStyles.bodySecondary,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
