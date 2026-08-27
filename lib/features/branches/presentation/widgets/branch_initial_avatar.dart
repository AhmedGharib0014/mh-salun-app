import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';

/// Square avatar showing a branch's initial, used as a lightweight stand-in
/// for a branch logo in list/summary contexts.
class BranchInitialAvatar extends StatelessWidget {
  const BranchInitialAvatar({
    super.key,
    required this.initial,
    this.size = AppSpacing.xxl,
    this.textStyle,
  });

  final String initial;
  final double size;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.35)),
      ),
      alignment: Alignment.center,
      child: Text(
        initial,
        style: (textStyle ?? AppTextStyles.titleMedium).copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
