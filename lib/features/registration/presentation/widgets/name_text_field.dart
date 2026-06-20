import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

/// Reusable required-text field for first / last name. The caller supplies the
/// label and hint keys so the same widget serves both name fields.
class NameTextField extends StatelessWidget {
  const NameTextField({
    super.key,
    required this.controller,
    required this.labelKey,
    required this.hintKey,
  });

  final TextEditingController controller;
  final String labelKey;
  final String hintKey;

  String? _validate(String? value) {
    if (value == null || value.trim().isEmpty) return 'auth_required_field'.tr();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        labelText: labelKey.tr(),
        hintText: hintKey.tr(),
      ),
      validator: _validate,
    );
  }
}
