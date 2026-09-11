import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mh_salun/core/di/injection.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';
import 'package:mh_salun/core/presentation/widgets/email_text_field.dart';
import 'package:mh_salun/features/login/bloc/reset_password/reset_password_bloc.dart';
import 'package:mh_salun/features/login/presentation/widgets/send_reset_link_button.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<ResetPasswordBloc>().add(
        ResetPasswordSubmitted(_emailController.text.trim()),
      );
    }
  }

  void _showMessageDialog(
    BuildContext context, {
    required String title,
    required String message,
    VoidCallback? onDismissed,
  }) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              onDismissed?.call();
            },
            child: Text('common_ok'.tr()),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ResetPasswordBloc>(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          leading: BackButton(
            color: AppColors.primary,
            onPressed: () => context.pop(),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppSpacing.xl),
                  Text(
                    'reset_password_title'.tr(),
                    style: AppTextStyles.headingGold,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'reset_password_subtitle'.tr(),
                    style: AppTextStyles.bodySecondary,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  EmailTextField(controller: _emailController),
                  const SizedBox(height: AppSpacing.xl),
                  BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
                    listener: (context, state) {
                      if (state is ResetPasswordSuccess) {
                        _showMessageDialog(
                          context,
                          title: 'reset_password_success_title'.tr(),
                          message: 'reset_password_success_message'.tr(),
                          onDismissed: () => context.pop(),
                        );
                      } else if (state is ResetPasswordFailure) {
                        _showMessageDialog(
                          context,
                          title: 'reset_password_error_title'.tr(),
                          message: state.message,
                        );
                      }
                    },
                    builder: (context, state) => SendResetLinkButton(
                      onPressed: () => _submit(context),
                      isLoading: state is ResetPasswordLoading,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
