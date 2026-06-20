import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({super.key, required this.controller});

  final TextEditingController controller;

  String? _validate(String? value) {
    if (value == null || value.isEmpty) return 'auth_required_field'.tr();
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(value)) return 'auth_invalid_email'.tr();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'auth_email_label'.tr(),
        hintText: 'auth_email_hint'.tr(),
      ),
      validator: _validate,
    );
  }
}
