import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';

/// Pill-shaped gradient CTA with a trailing arrow and a soft gold glow.
/// Hugs its label rather than filling the width, so it sits at the trailing
/// edge of the footer.
class ContinueButton extends StatelessWidget {
  const ContinueButton({
    super.key,
    required this.enabled,
    required this.label,
    required this.onTap,
    this.loading = false,
  });

  final bool enabled;
  final String label;
  final VoidCallback onTap;

  /// Swaps the label for a spinner and refuses taps while the action the
  /// button triggered is still running.
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final tappable = enabled && !loading;

    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.primaryLight, AppColors.primary],
          ),
          borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
          boxShadow: enabled
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.4),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: tappable ? onTap : null,
            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.md,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(label, style: AppTextStyles.buttonPrimary),
                  const SizedBox(width: AppSpacing.sm),
                  if (loading)
                    const SizedBox(
                      width: AppSpacing.iconSm,
                      height: AppSpacing.iconSm,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.onPrimary,
                      ),
                    )
                  else
                    const Icon(
                      Icons.arrow_forward_rounded,
                      size: AppSpacing.iconSm,
                      color: AppColors.onPrimary,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
