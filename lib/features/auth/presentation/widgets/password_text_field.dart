import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/app_colors.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    required this.controller,
    required this.validator,
    this.labelKey = 'auth_password_label',
    this.hintKey = 'auth_password_hint',
  });

  final TextEditingController controller;
  final String? Function(String?) validator;
  final String labelKey;
  final String hintKey;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscure = true;

  void _toggleVisibility() => setState(() => _obscure = !_obscure);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscure,
      decoration: InputDecoration(
        labelText: widget.labelKey.tr(),
        hintText: widget.hintKey.tr(),
        suffixIcon: IconButton(
          icon: Icon(
            _obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
            color: AppColors.onSurface,
          ),
          onPressed: _toggleVisibility,
        ),
      ),
      validator: widget.validator,
    );
  }
}
