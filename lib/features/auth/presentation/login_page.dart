import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mh_salun/core/router/app_router.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';
import 'package:mh_salun/features/auth/presentation/widgets/login/email_text_field.dart';
import 'package:mh_salun/features/auth/presentation/widgets/login/forgot_password_button.dart';
import 'package:mh_salun/features/auth/presentation/widgets/login/login_button.dart';
import 'package:mh_salun/features/auth/presentation/widgets/login/password_text_field.dart';

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
    if (value == null || value.isEmpty) return 'login_required_field'.tr();
    return null;
  }

  void _onForgotPassword() => context.pushNamed(AppRoutes.resetPassword);

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      // data wiring handled in integrate-feature phase
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                LoginButton(onPressed: _submit),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
