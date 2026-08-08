import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';

/// Centered placeholder shown when a reservations tab has nothing to list.
/// When [onActionTap] is provided, a button using [actionKey] is shown below
/// the message so the user can act on the empty state.
class EmptyReservationsState extends StatelessWidget {
  const EmptyReservationsState({
    super.key,
    required this.icon,
    required this.titleKey,
    this.subtitleKey,
    this.actionKey,
    this.onActionTap,
  }) : assert(
         (actionKey == null) == (onActionTap == null),
         'actionKey and onActionTap must be provided together',
       );

  final IconData icon;
  final String titleKey;
  final String? subtitleKey;
  final String? actionKey;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: AppSpacing.xxl + AppSpacing.md,
              height: AppSpacing.xxl + AppSpacing.md,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.12),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.35),
                ),
              ),
              alignment: Alignment.center,
              child: Icon(
                icon,
                size: AppSpacing.iconLg,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              titleKey.tr(),
              textAlign: TextAlign.center,
              style: AppTextStyles.titleMedium,
            ),
            if (subtitleKey != null) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(
                subtitleKey!.tr(),
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySecondary,
              ),
            ],
            if (actionKey != null) ...[
              const SizedBox(height: AppSpacing.lg),
              GestureDetector(
                onTap: onActionTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.sm + AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                  ),
                  child: Text(
                    actionKey!.tr(),
                    style: AppTextStyles.buttonPrimary,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
