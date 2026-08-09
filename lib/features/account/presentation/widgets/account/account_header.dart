import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';
import 'package:mh_salun/features/account/model/profile.dart';

/// Centered avatar (circular initials, matching the app's badge style)
/// plus the user's email.
class AccountHeader extends StatelessWidget {
  const AccountHeader({super.key, required this.profile});

  final Profile profile;

  static const double _avatarSize = 96;

  @override
  Widget build(BuildContext context) {
    final avatarUrl = profile.avatarUrl;
    return Column(
      children: [
        Container(
          width: _avatarSize,
          height: _avatarSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.surfaceHigh,
            border: Border.all(color: AppColors.primary, width: 2),
            image: avatarUrl == null
                ? null
                : DecorationImage(
                    image: NetworkImage(avatarUrl),
                    fit: BoxFit.cover,
                  ),
          ),
          alignment: Alignment.center,
          child: avatarUrl == null
              ? Text(profile.initials, style: AppTextStyles.headingGold)
              : null,
        ),
        const SizedBox(height: AppSpacing.md),
        Text(profile.email, style: AppTextStyles.bodySecondary),
      ],
    );
  }
}
