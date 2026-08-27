import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';

/// "View details" hint with a trailing chevron, prompting the user to open
/// the branch details page.
class BranchDetailsHint extends StatelessWidget {
  const BranchDetailsHint({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'branch_card_details_hint'.tr(),
          style: AppTextStyles.caption.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        const Icon(
          Icons.arrow_forward_ios,
          size: AppSpacing.iconSm - 6,
          color: AppColors.primary,
        ),
      ],
    );
  }
}
