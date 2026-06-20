import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class RegisterSuccessDialog extends StatelessWidget {
  const RegisterSuccessDialog({super.key, required this.onConfirm});

  final VoidCallback onConfirm;

  static Future<void> show(
    BuildContext context, {
    required VoidCallback onConfirm,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => RegisterSuccessDialog(onConfirm: onConfirm),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('register_success_title'.tr()),
      content: Text('register_success_message'.tr()),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
          child: Text('common_ok'.tr()),
        ),
      ],
    );
  }
}
