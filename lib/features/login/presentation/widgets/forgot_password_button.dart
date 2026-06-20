import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/text_styles.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          'login_forgot_password'.tr(),
          style: AppTextStyles.bodyGold,
        ),
      ),
    );
  }
}
