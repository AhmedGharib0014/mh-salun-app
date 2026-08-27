import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppErrorDialog extends StatelessWidget {
  const AppErrorDialog({super.key, required this.messageKey});

  final String messageKey;

  static Future<void> show(BuildContext context, String messageKey) {
    return showDialog<void>(
      context: context,
      builder: (_) => AppErrorDialog(messageKey: messageKey),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('common_error_title'.tr()),
      content: Text(messageKey.tr()),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('common_ok'.tr()),
        ),
      ],
    );
  }
}
