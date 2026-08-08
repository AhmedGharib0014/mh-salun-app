import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';

/// Title + subtitle shown at the top of a booking step, above its content.
class BookingStepHeader extends StatelessWidget {
  const BookingStepHeader({
    super.key,
    required this.titleKey,
    required this.subtitleKey,
  });

  final String titleKey;
  final String subtitleKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(titleKey.tr(), style: AppTextStyles.titleLarge),
        const SizedBox(height: AppSpacing.xs),
        Text(subtitleKey.tr(), style: AppTextStyles.bodySecondary),
      ],
    );
  }
}
