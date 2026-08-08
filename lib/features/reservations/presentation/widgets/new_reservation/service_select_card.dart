import 'package:flutter/material.dart';
import 'package:mh_salun/core/model/service.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';

/// Selectable service row for the "choose services" step. Tapping toggles the
/// service; a gold checkbox and border mark it as included in the booking.
class ServiceSelectCard extends StatelessWidget {
  const ServiceSelectCard({
    super.key,
    required this.service,
    required this.selected,
    required this.onTap,
  });

  final Service service;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary.withValues(alpha: 0.10)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
          border: Border.all(
            color: selected
                ? AppColors.primary
                : AppColors.primary.withValues(alpha: 0.18),
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: AppSpacing.xxl,
              height: AppSpacing.xxl,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.35),
                ),
              ),
              alignment: Alignment.center,
              child: Icon(
                service.icon,
                size: AppSpacing.iconMd,
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
                    style: AppTextStyles.titleMedium.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    service.description,
                    style: AppTextStyles.caption,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Row(
                    children: [
                      const Icon(
                        Icons.schedule,
                        size: AppSpacing.iconSm - 4,
                        color: AppColors.onSurface,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Text(service.duration, style: AppTextStyles.caption),
                      const SizedBox(width: AppSpacing.md),
                      Text(
                        service.price,
                        style: AppTextStyles.bodyGold.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            _Checkbox(selected: selected),
          ],
        ),
      ),
    );
  }
}

class _Checkbox extends StatelessWidget {
  const _Checkbox({required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: selected ? AppColors.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm + 2),
        border: Border.all(
          color: selected ? AppColors.primary : AppColors.outline,
          width: 2,
        ),
      ),
      child: selected
          ? const Icon(Icons.check, size: 16, color: AppColors.onPrimary)
          : null,
    );
  }
}
