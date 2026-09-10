import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';
import 'package:mh_salun/features/account/presentation/widgets/account/delete_account_confirm_dialog.dart';

/// Opens the delete-account confirmation dialog.
class DeleteAccountButton extends StatelessWidget {
  const DeleteAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: OutlinedButton.icon(
        onPressed: () => DeleteAccountConfirmDialog.show(context),
        icon: const Icon(Icons.delete_forever_outlined, size: 20),
        label: Text('delete_account_button'.tr()),
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
