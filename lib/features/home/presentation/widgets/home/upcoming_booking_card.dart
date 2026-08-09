import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';
import 'package:mh_salun/core/presentation/widgets/section_header.dart';
import 'package:mh_salun/features/home/presentation/widgets/home/info_chip.dart';

class UpcomingBookingCard extends StatelessWidget {
  const UpcomingBookingCard({super.key, required this.onSeeAllTap});

  final VoidCallback onSeeAllTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(
          titleKey: 'home_upcoming_title',
          actionKey: 'home_see_all',
          onActionTap: onSeeAllTap,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
            border: Border.all(color: AppColors.divider),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.surfaceHigh,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
                  border: Border.all(color: AppColors.outline),
                ),
                alignment: Alignment.center,
                child: Text(
                  'home_upcoming_barber_name'.tr().substring(0, 1),
                  style: AppTextStyles.headingGold,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'home_upcoming_barber_name'.tr(),
                      style: AppTextStyles.titleMedium.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'home_upcoming_services'.tr(),
                      style: AppTextStyles.bodySecondary,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Wrap(
                      spacing: AppSpacing.md,
                      runSpacing: AppSpacing.xs,
                      children: [
                        InfoChip(emoji: '📅', label: 'home_today'.tr()),
                        InfoChip(
                          emoji: '🕐',
                          label: 'home_time_placeholder'.tr(),
                        ),
                        InfoChip(emoji: '⏱', label: 'home_duration_60'.tr()),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
