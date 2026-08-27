import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/features/account/model/profile.dart';
import 'package:mh_salun/features/account/presentation/widgets/account/info_row.dart';

/// Card listing the user's profile fields as labeled rows.
class AccountInfoSection extends StatelessWidget {
  const AccountInfoSection({super.key, required this.profile});

  final Profile profile;

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
          InfoRow(
            labelKey: 'account_first_name_label',
            value: profile.firstName,
          ),
          const Divider(color: AppColors.divider, height: AppSpacing.lg),
          InfoRow(labelKey: 'account_last_name_label', value: profile.lastName),
          const Divider(color: AppColors.divider, height: AppSpacing.lg),
          InfoRow(
            labelKey: 'account_dob_label',
            value: profile.dateOfBirth == null
                ? 'account_not_provided'.tr()
                : DateFormat('yyyy-MM-dd').format(profile.dateOfBirth!),
          ),
        ],
      ),
    );
  }
}
