import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';

/// Bottom-of-form prompt that links between the login and registration screens.
class AuthSwitchLink extends StatelessWidget {
  const AuthSwitchLink({
    super.key,
    required this.promptKey,
    required this.actionKey,
    required this.onTap,
  });

  final String promptKey;
  final String actionKey;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(promptKey.tr(), style: AppTextStyles.bodySecondary),
        const SizedBox(width: AppSpacing.xs),
        GestureDetector(
          onTap: onTap,
          child: Text(actionKey.tr(), style: AppTextStyles.bodyGold),
        ),
      ],
    );
  }
}
