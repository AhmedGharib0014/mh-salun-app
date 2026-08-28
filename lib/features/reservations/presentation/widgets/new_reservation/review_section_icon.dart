import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';

/// Small gold-tinted square holding a review section's leading icon.
class ReviewSectionIcon extends StatelessWidget {
  const ReviewSectionIcon({super.key, required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSpacing.lg + AppSpacing.xs,
      height: AppSpacing.lg + AppSpacing.xs,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      alignment: Alignment.center,
      child: Icon(icon, size: AppSpacing.iconSm - 2, color: AppColors.primary),
    );
  }
}
