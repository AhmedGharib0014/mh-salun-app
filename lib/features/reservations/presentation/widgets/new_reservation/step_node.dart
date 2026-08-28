import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';

/// Numbered gold node in the stepper. Completed steps collapse to a check and
/// the active step gets a glowing ring.
class StepNode extends StatelessWidget {
  const StepNode({
    super.key,
    required this.index,
    required this.done,
    required this.active,
  });

  final int index;
  final bool done;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final bool reached = done || active;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: reached
            ? const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.primaryLight, AppColors.primary],
              )
            : null,
        color: reached ? null : AppColors.surfaceHigh,
        border: Border.all(
          color: reached
              ? AppColors.primaryLight
              : AppColors.primary.withValues(alpha: 0.25),
          width: active ? 2 : 1,
        ),
        boxShadow: active
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.45),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
      alignment: Alignment.center,
      child: done
          ? const Icon(
              Icons.check_rounded,
              size: AppSpacing.iconSm,
              color: AppColors.onPrimary,
            )
          : Text(
              '${index + 1}',
              style: AppTextStyles.label.copyWith(
                color: active
                    ? AppColors.onPrimary
                    : AppColors.primary.withValues(alpha: 0.6),
                fontWeight: FontWeight.w700,
              ),
            ),
    );
  }
}
