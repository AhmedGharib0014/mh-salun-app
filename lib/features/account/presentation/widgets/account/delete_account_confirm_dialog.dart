import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/app_colors.dart';

/// Asks the user to confirm permanently deleting their account and data.
///
/// Presentation-only for now: confirming just dismisses the dialog. Wiring
/// the actual deletion (bloc event + repository call) happens once the
/// delete-account data layer exists.
class DeleteAccountConfirmDialog extends StatelessWidget {
  const DeleteAccountConfirmDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (_) => const DeleteAccountConfirmDialog(),
    );
  }

  void _onConfirm(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('delete_account_confirm_title'.tr()),
      content: Text('delete_account_confirm_message'.tr()),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('delete_account_confirm_cancel'.tr()),
        ),
        TextButton(
          onPressed: () => _onConfirm(context),
          child: Text(
            'delete_account_confirm_action'.tr(),
            style: const TextStyle(color: AppColors.error),
          ),
        ),
      ],
    );
  }
}
