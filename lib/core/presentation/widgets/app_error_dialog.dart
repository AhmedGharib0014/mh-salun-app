import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppErrorDialog extends StatelessWidget {
  const AppErrorDialog({super.key, required this.message});

  final String message;

  static Future<void> show(BuildContext context, String message) {
    return showDialog<void>(
      context: context,
      builder: (_) => AppErrorDialog(message: message),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('common_error_title'.tr()),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('common_ok'.tr()),
        ),
      ],
    );
  }
}
