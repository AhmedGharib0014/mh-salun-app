import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';

/// Trailing radio-style indicator: a hollow outline until the branch is picked,
/// then a filled gold disc with a check.
class SelectionMark extends StatelessWidget {
  const SelectionMark({super.key, required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: AppSpacing.iconMd,
      height: AppSpacing.iconMd,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: selected ? AppColors.primary : Colors.transparent,
        border: Border.all(
          color: selected ? AppColors.primary : AppColors.outline,
          width: 2,
        ),
      ),
      alignment: Alignment.center,
      child: selected
          ? const Icon(
              Icons.check,
              size: AppSpacing.iconSm - 5,
              color: AppColors.onPrimary,
            )
          : null,
    );
  }
}
