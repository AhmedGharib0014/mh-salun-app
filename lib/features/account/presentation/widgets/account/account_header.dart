import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';
import 'package:mh_salun/features/account/model/account_profile.dart';

/// Centered avatar (circular initials, matching the app's badge style)
/// plus the user's email.
class AccountHeader extends StatelessWidget {
  const AccountHeader({super.key, required this.profile});

  final AccountProfile profile;

  static const double _avatarSize = 96;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: _avatarSize,
          height: _avatarSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.surfaceHigh,
            border: Border.all(color: AppColors.primary, width: 2),
          ),
          alignment: Alignment.center,
          child: Text(profile.initials, style: AppTextStyles.headingGold),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(profile.email, style: AppTextStyles.bodySecondary),
      ],
    );
  }
}
