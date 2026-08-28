import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/model/barber.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';

/// Read-only barber summary shown in the review step: ringed initial avatar,
/// name, role and rating pill.
class BarberRow extends StatelessWidget {
  const BarberRow({super.key, required this.barber});

  final Barber barber;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Avatar with a gradient gold ring around a dark inner disc.
        Container(
          padding: const EdgeInsets.all(2),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primaryLight, AppColors.primary],
            ),
          ),
          child: Container(
            width: AppSpacing.xxl,
            height: AppSpacing.xxl,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.surfaceHigh,
            ),
            alignment: Alignment.center,
            child: Text(barber.initial, style: AppTextStyles.titleLarge),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                barber.name,
                style: AppTextStyles.titleMedium.copyWith(
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'new_reservation_review_barber_role'.tr(),
                style: AppTextStyles.caption,
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        // Rating pill.
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs,
          ),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.star_rounded,
                size: AppSpacing.iconSm - 3,
                color: AppColors.primary,
              ),
              const SizedBox(width: 2),
              Text(
                barber.rating,
                style: AppTextStyles.bodyGold.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
