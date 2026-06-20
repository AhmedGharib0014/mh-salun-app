import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mh_salun/core/router/app_router.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';
import 'package:mh_salun/core/presentation/widgets/auth_switch_link.dart';
import 'package:mh_salun/core/presentation/widgets/email_text_field.dart';
import 'package:mh_salun/features/registration/presentation/widgets/birth_date_field.dart';
import 'package:mh_salun/features/registration/presentation/widgets/name_text_field.dart';
import 'package:mh_salun/features/registration/presentation/widgets/password_fields.dart';
import 'package:mh_salun/features/registration/presentation/widgets/register_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  DateTime? _birthDate;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onBirthDateChanged(DateTime? date) =>
      setState(() => _birthDate = date);

  void _onLoginTap() => context.goNamed(AppRoutes.login);

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
                  'register_title'.tr(),
                  style: AppTextStyles.headingGold,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.xxl),
                NameTextField(
                  controller: _firstNameController,
                  labelKey: 'register_first_name_label',
                  hintKey: 'register_first_name_hint',
                ),
                const SizedBox(height: AppSpacing.md),
                NameTextField(
                  controller: _lastNameController,
                  labelKey: 'register_last_name_label',
                  hintKey: 'register_last_name_hint',
                ),
                const SizedBox(height: AppSpacing.md),
                EmailTextField(controller: _emailController),
                const SizedBox(height: AppSpacing.md),
                PasswordFields(passwordController: _passwordController),
                const SizedBox(height: AppSpacing.md),
                BirthDateField(
                  value: _birthDate,
                  onChanged: _onBirthDateChanged,
                ),
                const SizedBox(height: AppSpacing.xl),
                RegisterButton(onPressed: _submit),
                const SizedBox(height: AppSpacing.lg),
                AuthSwitchLink(
                  promptKey: 'auth_have_account',
                  actionKey: 'auth_login_action',
                  onTap: _onLoginTap,
                ),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
