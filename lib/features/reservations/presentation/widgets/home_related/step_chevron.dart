import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';

class StepChevron extends StatelessWidget {
  const StepChevron({super.key});

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == ui.TextDirection.rtl;
    return Icon(
      isRtl ? Icons.chevron_right : Icons.chevron_left,
      size: AppSpacing.iconSm - 4,
      color: AppColors.onPrimary.withValues(alpha: 0.55),
    );
  }
}
