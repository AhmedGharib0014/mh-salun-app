import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';
import 'package:mh_salun/features/account/model/account_profile.dart';

/// Card listing the user's profile fields as labeled rows.
class AccountInfoSection extends StatelessWidget {
  const AccountInfoSection({super.key, required this.profile});

  final AccountProfile profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: [
          _InfoRow(
            labelKey: 'account_first_name_label',
            value: profile.firstName,
          ),
          const Divider(color: AppColors.divider, height: AppSpacing.lg),
          _InfoRow(
            labelKey: 'account_last_name_label',
            value: profile.lastName,
          ),
          const Divider(color: AppColors.divider, height: AppSpacing.lg),
          _InfoRow(labelKey: 'account_email_label', value: profile.email),
          const Divider(color: AppColors.divider, height: AppSpacing.lg),
          _InfoRow(
            labelKey: 'account_age_label',
            value: profile.age.toString(),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.labelKey, required this.value});

  final String labelKey;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          Expanded(
            child: Text(labelKey.tr(), style: AppTextStyles.label),
          ),
          Text(value, style: AppTextStyles.bodyRegular),
        ],
      ),
    );
  }
}
