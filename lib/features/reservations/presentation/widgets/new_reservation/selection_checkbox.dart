import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';

/// Square gold checkbox used by the selectable cards of the booking steps.
class SelectionCheckbox extends StatelessWidget {
  const SelectionCheckbox({super.key, required this.selected});

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
