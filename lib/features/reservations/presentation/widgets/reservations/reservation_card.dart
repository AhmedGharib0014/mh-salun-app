import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/font_sizes.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';
import 'package:mh_salun/features/reservations/model/booked_reservation.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/home_related/info_chip.dart';

class ReservationCard extends StatelessWidget {
  const ReservationCard({super.key, required this.reservation});

  final BookedReservation reservation;

  /// Barber the reservation is with. The employee is filled in by the
  /// backend's enrichment step; until then the card shows a neutral label.
  String get _barberName {
    final name = reservation.employee?.fullName ?? '';
    return name.isEmpty ? 'reservations_barber_fallback'.tr() : name;
  }

  String get _barberInitial =>
      _barberName.isEmpty ? '' : _barberName[0].toUpperCase();

  /// Booked services, or a placeholder while the backend is still enriching
  /// the reservation and the item names are null.
  String get _servicesLabel {
    final names = reservation.items
        .map((item) => item.name)
        .whereType<String>()
        .toList();
    return names.isEmpty
        ? 'reservations_services_pending'.tr()
        : names.join(' · ');
  }

  ({String key, Color color}) get _statusStyle {
    switch (reservation.status.toUpperCase()) {
      case 'COMPLETED':
        return (
          key: 'reservations_status_completed',
          color: AppColors.onSurface,
        );
      case 'CANCELLED':
      case 'CANCELED':
        return (key: 'reservations_status_cancelled', color: AppColors.error);
      case 'BOOKED':
      default:
        return (key: 'home_status_confirmed', color: Colors.lightGreen);
    }
  }

  /// `Today` for a reservation on the current day, the weekday and date
  /// otherwise.
  String _dateLabel(BuildContext context) {
    final startsAt = reservation.startsAt;
    final now = DateTime.now();
    final isToday =
        startsAt.year == now.year &&
        startsAt.month == now.month &&
        startsAt.day == now.day;
    return isToday
        ? 'home_today'.tr()
        : DateFormat('EEE, d MMM', context.locale.toString()).format(startsAt);
  }

  @override
  Widget build(BuildContext context) {
    final status = _statusStyle;
    final locale = context.locale.toString();
    final durationMinutes = reservation.endsAt
        .difference(reservation.startsAt)
        .inMinutes;

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
            child: Text(_barberInitial, style: AppTextStyles.headingGold),
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
                        _barberName,
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
                Text(_servicesLabel, style: AppTextStyles.bodySecondary),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.md,
                  runSpacing: AppSpacing.xs,
                  children: [
                    InfoChip(emoji: '📅', label: _dateLabel(context)),
                    InfoChip(
                      emoji: '🕐',
                      label: DateFormat.jm(
                        locale,
                      ).format(reservation.startsAt),
                    ),
                    InfoChip(
                      emoji: '⏱',
                      label: 'reservations_duration_minutes'.tr(
                        args: ['$durationMinutes'],
                      ),
                    ),
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
