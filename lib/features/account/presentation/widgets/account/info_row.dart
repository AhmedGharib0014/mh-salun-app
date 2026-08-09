import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';

/// A single labeled value row.
class InfoRow extends StatelessWidget {
  const InfoRow({super.key, required this.labelKey, required this.value});

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
