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
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: TextButton(
        onPressed: () => DeleteAccountConfirmDialog.show(context),
        style: TextButton.styleFrom(
          foregroundColor: AppColors.error,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm,
          ),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          textStyle: AppTextStyles.buttonPrimary.copyWith(fontSize: 14),
        ),
        child: Text('delete_account_button'.tr()),
      ),
    );
  }
}
