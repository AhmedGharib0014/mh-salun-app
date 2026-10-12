import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';
import 'package:mh_salun/core/utils/currency.dart';

/// Info note on the review step telling the guest that the organization's
/// fixed app [fee] is added on top of the services' total.
class AppFeeNote extends StatelessWidget {
  const AppFeeNote({super.key, required this.fee});

  final num fee;

  @override
  Widget build(BuildContext context) {
    final amount = NumberFormat.decimalPattern(
      context.locale.toString(),
    ).format(fee);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.24)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline_rounded,
            size: AppSpacing.iconSm,
            color: AppColors.primary,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              'new_reservation_review_app_fee_note'.tr(
                args: ['$amount $currencySymbol'],
              ),
              style: AppTextStyles.bodySecondary,
            ),
          ),
        ],
      ),
    );
  }
}
