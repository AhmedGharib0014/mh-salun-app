import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';

/// Centered icon + message filling the step body when there is nothing to pick
/// from — either the branches failed to load or the salon has none.
class StepMessage extends StatelessWidget {
  const StepMessage({super.key, required this.icon, required this.messageKey});

  final IconData icon;
  final String messageKey;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: AppSpacing.iconLg,
              color: AppColors.primary.withValues(alpha: 0.6),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              messageKey.tr(),
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySecondary,
            ),
          ],
        ),
      ),
    );
  }
}
