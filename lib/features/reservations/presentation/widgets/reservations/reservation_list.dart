import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/features/reservations/model/reservation.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/reservations/reservation_card.dart';

class ReservationList extends StatelessWidget {
  const ReservationList({super.key, required this.reservations});

  final List<Reservation> reservations;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.bottomNavClearance + MediaQuery.of(context).padding.bottom,
      ),
      itemCount: reservations.length,
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppSpacing.md),
      itemBuilder: (context, index) =>
          ReservationCard(reservation: reservations[index]),
    );
  }
}
