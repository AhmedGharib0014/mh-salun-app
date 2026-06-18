import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mh_salun/core/di/injection.dart';
import 'package:mh_salun/core/router/app_router.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';
import 'package:mh_salun/core/presentation/widgets/auth_switch_link.dart';
import 'package:mh_salun/core/presentation/widgets/email_text_field.dart';
import 'package:mh_salun/core/presentation/widgets/password_text_field.dart';
import 'package:mh_salun/features/login/bloc/login_bloc.dart';
import 'package:mh_salun/features/login/presentation/widgets/forgot_password_button.dart';
import 'package:mh_salun/features/login/presentation/widgets/login_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateRequired(String? value) {
    if (value == null || value.isEmpty) return 'auth_required_field'.tr();
    return null;
  }

  void _onForgotPassword() => context.pushNamed(AppRoutes.resetPassword);

  void _onRegisterTap() => context.goNamed(AppRoutes.register);

  void _submit(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<LoginBloc>().add(
            LoginSubmitted(
              _emailController.text.trim(),
              _passwordController.text,
            ),
          );
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('login_error_title'.tr()),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text('common_ok'.tr()),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LoginBloc>(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppSpacing.xxl),
                  Text(
                    'login_title'.tr(),
                    style: AppTextStyles.headingGold,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  EmailTextField(controller: _emailController),
                  const SizedBox(height: AppSpacing.md),
                  PasswordTextField(
                    controller: _passwordController,
                    validator: _validateRequired,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  ForgotPasswordButton(onTap: _onForgotPassword),
                  const SizedBox(height: AppSpacing.xl),
                  BlocConsumer<LoginBloc, LoginState>(
                    listener: (context, state) {
                      if (state is LoginSuccess) {
                        context.goNamed(AppRoutes.home);
                      } else if (state is LoginFailure) {
                        _showErrorDialog(context, state.message);
                      }
                    },
                    builder: (context, state) => LoginButton(
                      onPressed: () => _submit(context),
                      isLoading: state is LoginLoading,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AuthSwitchLink(
                    promptKey: 'auth_no_account',
                    actionKey: 'auth_register_action',
                    onTap: _onRegisterTap,
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
