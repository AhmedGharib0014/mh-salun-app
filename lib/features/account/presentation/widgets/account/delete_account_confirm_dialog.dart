import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mh_salun/core/di/injection.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/features/account/bloc/delete_account/delete_account_bloc.dart';
import 'package:mh_salun/features/auth/bloc/auth_bloc.dart';

/// Asks the user to confirm permanently deleting their account and data.
///
/// Confirming fires [DeleteAccountSubmitted]; once the backend deletes the
/// account, [LogoutRequested] is fired and the global auth listener handles
/// navigation and the session cache teardown.
class DeleteAccountConfirmDialog extends StatelessWidget {
  const DeleteAccountConfirmDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (_) => BlocProvider(
        create: (_) => getIt<DeleteAccountBloc>(),
        child: const DeleteAccountConfirmDialog(),
      ),
    );
  }

  void _onStateChanged(BuildContext context, DeleteAccountState state) {
    if (state is DeleteAccountSuccess) {
      final authBloc = context.read<AuthBloc>();
      Navigator.of(context).pop();
      authBloc.add(LogoutRequested());
    }
    if (state is DeleteAccountFailure) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(state.message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteAccountBloc, DeleteAccountState>(
      listener: _onStateChanged,
      builder: (context, state) {
        final isLoading = state is DeleteAccountLoading;
        return PopScope(
          canPop: !isLoading,
          child: AlertDialog(
            title: Text('delete_account_confirm_title'.tr()),
            content: Text('delete_account_confirm_message'.tr()),
            actions: [
              TextButton(
                onPressed: isLoading ? null : () => Navigator.of(context).pop(),
                child: Text('delete_account_confirm_cancel'.tr()),
              ),
              TextButton(
                onPressed: isLoading
                    ? null
                    : () => context
                        .read<DeleteAccountBloc>()
                        .add(DeleteAccountSubmitted()),
                child: isLoading
                    ? const SizedBox.square(
                        dimension: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.error,
                        ),
                      )
                    : Text(
                        'delete_account_confirm_action'.tr(),
                        style: const TextStyle(color: AppColors.error),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
