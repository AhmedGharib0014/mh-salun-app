import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';
import 'package:mh_salun/features/account/presentation/widgets/account/logout_confirm_dialog.dart';

/// Opens the logout confirmation dialog, which owns the logout itself.
class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: OutlinedButton.icon(
        onPressed: () => LogoutConfirmDialog.show(context),
        icon: const Icon(Icons.logout, size: 20),
        label: Text('logout_button'.tr()),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.error,
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          side: const BorderSide(color: AppColors.error),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          ),
          textStyle: AppTextStyles.buttonPrimary,
        ),
      ),
    );
  }
}
