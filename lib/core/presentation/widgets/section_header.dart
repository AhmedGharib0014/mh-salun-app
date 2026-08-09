import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.titleKey,
    this.actionKey,
    this.onActionTap,
  }) : assert(
         (actionKey == null) == (onActionTap == null),
         'actionKey and onActionTap must be provided together',
       );

  final String titleKey;
  final String? actionKey;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(titleKey.tr(), style: AppTextStyles.titleLarge),
          if (actionKey != null)
            GestureDetector(
              onTap: onActionTap,
              child: Text(
                actionKey!.tr(),
                style: AppTextStyles.bodyGold.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
