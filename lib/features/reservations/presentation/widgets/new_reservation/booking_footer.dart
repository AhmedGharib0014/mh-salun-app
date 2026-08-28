import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/continue_button.dart';

/// Bottom bar carrying the primary continue button.
class BookingFooter extends StatelessWidget {
  const BookingFooter({
    super.key,
    required this.buttonLabel,
    required this.canContinue,
    required this.onContinue,
  });

  final String buttonLabel;
  final bool canContinue;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.divider)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ContinueButton(
                enabled: canContinue,
                label: buttonLabel,
                onTap: onContinue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
