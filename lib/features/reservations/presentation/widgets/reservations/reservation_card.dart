import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/font_sizes.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';
import 'package:mh_salun/features/reservations/model/reservation.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/home_related/info_chip.dart';

class ReservationCard extends StatelessWidget {
  const ReservationCard({super.key, required this.reservation});

  final Reservation reservation;

  ({String key, Color color}) get _statusStyle {
    switch (reservation.status) {
      case ReservationStatus.confirmed:
        return (key: 'home_status_confirmed', color: Colors.lightGreen);
      case ReservationStatus.completed:
        return (
          key: 'reservations_status_completed',
          color: AppColors.onSurface,
        );
      case ReservationStatus.cancelled:
        return (key: 'reservations_status_cancelled', color: AppColors.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = _statusStyle;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.surfaceHigh,
              borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
              border: Border.all(color: AppColors.outline),
            ),
            alignment: Alignment.center,
            child: Text(reservation.barberInitial, style: AppTextStyles.headingGold),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        reservation.barberName,
                        style: AppTextStyles.titleMedium.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: status.color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusFull,
                        ),
                      ),
                      child: Text(
                        status.key.tr(),
                        style: TextStyle(
                          fontSize: AppFontSize.label,
                          fontWeight: FontWeight.w700,
                          color: status.color,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(reservation.services, style: AppTextStyles.bodySecondary),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.md,
                  runSpacing: AppSpacing.xs,
                  children: [
                    InfoChip(emoji: '📅', label: reservation.dateLabel),
                    InfoChip(emoji: '🕐', label: reservation.timeLabel),
                    InfoChip(emoji: '⏱', label: reservation.durationLabel),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
