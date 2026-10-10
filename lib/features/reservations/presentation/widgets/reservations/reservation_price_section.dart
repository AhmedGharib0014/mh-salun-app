import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';
import 'package:mh_salun/core/utils/currency.dart';
import 'package:mh_salun/features/reservations/model/booked_reservation.dart';

/// Price breakdown (services + fee, and the total) for a booked reservation,
/// shown once the backend's enrichment step has filled the pricing in.
///
/// Currently unused — reservation prices are hidden in the UI — but kept as a
/// standalone widget so the display can be switched back on without rewriting
/// it. It was previously rendered inline at the bottom of `ReservationCard`;
/// drop it back in after the info chips to restore the behaviour.
class ReservationPriceSection extends StatelessWidget {
  const ReservationPriceSection({super.key, required this.reservation});

  final BookedReservation reservation;

  /// Price formatted with the active locale's digits and the app's currency.
  String _price(BuildContext context, num amount) {
    final digits = NumberFormat.decimalPattern(
      context.locale.toString(),
    ).format(amount);
    return '$digits $currencySymbol';
  }

  @override
  Widget build(BuildContext context) {
    if (reservation.totalPrice == null) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.sm),
        const Divider(height: 1, color: AppColors.divider),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'reservations_total_label'.tr(),
                    style: AppTextStyles.bodySecondary,
                  ),
                  if (reservation.servicesCost != null &&
                      reservation.appFee != null)
                    Text(
                      'reservations_price_breakdown'.tr(
                        args: [
                          _price(context, reservation.servicesCost!),
                          _price(context, reservation.appFee!),
                        ],
                      ),
                      style: AppTextStyles.caption,
                    ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              _price(context, reservation.totalPrice!),
              style: AppTextStyles.titleGold,
            ),
          ],
        ),
      ],
    );
  }
}
