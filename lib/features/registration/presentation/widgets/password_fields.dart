import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/presentation/widgets/password_text_field.dart';

/// Password + confirm-password pair for registration. Owns the confirm
/// controller and keeps all password-related validation — required, minimum
/// length, and equality between the two fields — encapsulated here.
class PasswordFields extends StatefulWidget {
  const PasswordFields({super.key, required this.passwordController});

  final TextEditingController passwordController;

  @override
  State<PasswordFields> createState() => _PasswordFieldsState();
}

class _PasswordFieldsState extends State<PasswordFields> {
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _confirmController.dispose();
    super.dispose();
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'auth_required_field'.tr();
    if (value.length < 6) return 'register_password_too_short'.tr();
    return null;
  }

  String? _validateConfirm(String? value) {
    if (value == null || value.isEmpty) return 'auth_required_field'.tr();
    if (value != widget.passwordController.text) {
      return 'register_password_mismatch'.tr();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PasswordTextField(
          controller: widget.passwordController,
          validator: _validatePassword,
        ),
        const SizedBox(height: AppSpacing.md),
        PasswordTextField(
          controller: _confirmController,
          validator: _validateConfirm,
          labelKey: 'register_confirm_password_label',
          hintKey: 'register_confirm_password_hint',
        ),
      ],
    );
  }
}
