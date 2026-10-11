import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

/// Required Egyptian mobile number field (`01x…`, `+201x…` or `00201x…`).
class PhoneTextField extends StatelessWidget {
  const PhoneTextField({super.key, required this.controller});

  final TextEditingController controller;

  static final _phoneRegex = RegExp(r'^(\+20|0020|0)1[0125]\d{8}$');

  String? _validate(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'auth_required_field'.tr();
    if (!_phoneRegex.hasMatch(text)) return 'register_phone_invalid'.tr();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: 'register_phone_label'.tr(),
        hintText: 'register_phone_hint'.tr(),
      ),
      validator: _validate,
    );
  }
}
