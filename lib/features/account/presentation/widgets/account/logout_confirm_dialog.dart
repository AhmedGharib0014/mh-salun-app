import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/features/auth/bloc/auth_bloc.dart';

/// Asks the user to confirm logging out, and fires [LogoutRequested] when they
/// do. Navigation and the session cache teardown are handled by the global
/// auth listener.
class LogoutConfirmDialog extends StatelessWidget {
  const LogoutConfirmDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (_) => const LogoutConfirmDialog(),
    );
  }

  void _onConfirm(BuildContext context) {
    context.read<AuthBloc>().add(LogoutRequested());
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('logout_confirm_title'.tr()),
      content: Text('logout_confirm_message'.tr()),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('logout_confirm_cancel'.tr()),
        ),
        TextButton(
          onPressed: () => _onConfirm(context),
          child: Text(
            'logout_confirm_action'.tr(),
            style: const TextStyle(color: AppColors.error),
          ),
        ),
      ],
    );
  }
}
