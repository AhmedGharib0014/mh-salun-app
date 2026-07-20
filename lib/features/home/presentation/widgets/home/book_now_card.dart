import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/font_sizes.dart';
import 'package:mh_salun/core/theme/spacing.dart';

class BookNowCard extends StatelessWidget {
  const BookNowCard({super.key, required this.onStartBooking});

  final VoidCallback onStartBooking;

  Widget _step(String labelKey) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm + AppSpacing.xs,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
      ),
      child: Text(
        labelKey.tr(),
        style: const TextStyle(
          fontSize: AppFontSize.caption,
          fontWeight: FontWeight.w700,
          color: AppColors.onPrimary,
        ),
      ),
    );
  }

  Widget _stepChevron(BuildContext context) {
    final isRtl = Directionality.of(context) == ui.TextDirection.rtl;
    return Icon(
      isRtl ? Icons.chevron_left : Icons.chevron_right,
      size: AppSpacing.iconSm - 4,
      color: AppColors.onPrimary.withValues(alpha: 0.55),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        0,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.primaryLight, AppColors.primary],
          ),
          borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.25),
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
          child: Stack(
            children: [
              // Defined luminous disc in the top-left corner (soft edge).
              Positioned(
                top: -30,
                left: 8,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.primaryLight.withValues(alpha: 0.65),
                        AppColors.primaryLight.withValues(alpha: 0.65),
                        AppColors.primaryLight.withValues(alpha: 0.0),
                      ],
                      stops: const [0.0, 0.62, 1.0],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: _content(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _content(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'home_book_subtitle'.tr(),
          style: const TextStyle(
            fontSize: AppFontSize.caption,
            fontWeight: FontWeight.w700,
            color: AppColors.onPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'home_book_title'.tr(),
          style: const TextStyle(
            fontSize: AppFontSize.display,
            fontWeight: FontWeight.w800,
            color: AppColors.onPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _step('home_book_step_barber'),
            _stepChevron(context),
            _step('home_book_step_service'),
            _stepChevron(context),
            _step('home_book_step_time'),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        GestureDetector(
          onTap: onStartBooking,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.sm + AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: AppColors.onPrimary,
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'home_book_button'.tr(),
                  style: const TextStyle(
                    fontSize: AppFontSize.body,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                const Icon(
                  Icons.arrow_forward,
                  size: AppSpacing.iconSm - 2,
                  color: AppColors.primary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
