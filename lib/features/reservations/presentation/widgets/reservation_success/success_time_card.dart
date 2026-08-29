import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';

/// The booked appointment's day and time range, as returned by the booking
/// call. Owns its own formatting — the page hands it the raw timestamps.
class SuccessTimeCard extends StatelessWidget {
  const SuccessTimeCard({
    super.key,
    required this.startsAt,
    required this.endsAt,
  });

  final DateTime startsAt;
  final DateTime endsAt;

  @override
  Widget build(BuildContext context) {
    final locale = context.locale.toLanguageTag();
    final date = DateFormat('EEEE, d MMMM', locale).format(startsAt);
    final clock = DateFormat.jm(locale);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.18)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.event_available_rounded,
                size: AppSpacing.iconSm,
                color: AppColors.primary,
              ),
              const SizedBox(width: AppSpacing.sm),
              Flexible(
                child: Text(
                  date,
                  style: AppTextStyles.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            '${clock.format(startsAt)} - ${clock.format(endsAt)}',
            style: AppTextStyles.bodyGold,
          ),
        ],
      ),
    );
  }
}
