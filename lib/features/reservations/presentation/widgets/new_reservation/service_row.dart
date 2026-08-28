import 'package:flutter/material.dart';
import 'package:mh_salun/core/model/service.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';

/// Read-only service summary shown in the review step: icon badge, name,
/// duration and price.
class ServiceRow extends StatelessWidget {
  const ServiceRow({super.key, required this.service});

  final Service service;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: AppSpacing.xl,
          height: AppSpacing.xl,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          alignment: Alignment.center,
          child: Icon(
            service.icon,
            size: AppSpacing.iconSm,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                service.name,
                style: AppTextStyles.bodyRegular.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  const Icon(
                    Icons.schedule_rounded,
                    size: AppSpacing.iconSm - 4,
                    color: AppColors.onSurface,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(service.duration, style: AppTextStyles.caption),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          service.price,
          style: AppTextStyles.bodyGold.copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
