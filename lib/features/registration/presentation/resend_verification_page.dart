import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mh_salun/core/di/injection.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';
import 'package:mh_salun/core/presentation/widgets/email_text_field.dart';
import 'package:mh_salun/features/registration/bloc/resend_verification/resend_verification_bloc.dart';
import 'package:mh_salun/features/registration/presentation/widgets/resend_verification_button.dart';

class ResendVerificationPage extends StatefulWidget {
  const ResendVerificationPage({super.key});

  @override
  State<ResendVerificationPage> createState() => _ResendVerificationPageState();
}

class _ResendVerificationPageState extends State<ResendVerificationPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<ResendVerificationBloc>().add(
        ResendVerificationSubmitted(_emailController.text.trim()),
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
      create: (_) => getIt<ResendVerificationBloc>(),
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
                    'resend_verification_title'.tr(),
                    style: AppTextStyles.headingGold,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'resend_verification_subtitle'.tr(),
                    style: AppTextStyles.bodySecondary,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  EmailTextField(controller: _emailController),
                  const SizedBox(height: AppSpacing.xl),
                  BlocConsumer<ResendVerificationBloc,
                      ResendVerificationState>(
                    listener: (context, state) {
                      if (state is ResendVerificationSuccess) {
                        _showMessageDialog(
                          context,
                          title: 'resend_verification_success_title'.tr(),
                          message: 'resend_verification_success_message'.tr(),
                          onDismissed: () => context.pop(),
                        );
                      } else if (state is ResendVerificationFailure) {
                        _showMessageDialog(
                          context,
                          title: 'resend_verification_error_title'.tr(),
                          message: state.message,
                        );
                      }
                    },
                    builder: (context, state) => ResendVerificationButton(
                      onPressed: () => _submit(context),
                      isLoading: state is ResendVerificationLoading,
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
