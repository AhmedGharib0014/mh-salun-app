import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mh_salun/core/router/app_router.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';
import 'package:mh_salun/features/home/bloc/home_tab/home_tab_cubit.dart';
import 'package:mh_salun/features/reservations/model/booked_reservation.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/reservation_success/go_to_reservations_button.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/reservation_success/success_badge.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/reservation_success/success_time_card.dart';

/// Shown once `POST /reservations` has confirmed the booking. The flow is over
/// by the time this is on screen, so there is no way back into it — the only
/// exit leads to the guest's reservations.
class ReservationSuccessPage extends StatelessWidget {
  const ReservationSuccessPage({super.key, required this.reservation});

  final BookedReservation reservation;

  void _onGoToReservations(BuildContext context) {
    // The shell reads its destination from the cubit as it comes up.
    context.read<HomeTabCubit>().show(HomeTab.reservations);
    context.goNamed(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // Popping would land back on the flow of a booking already made.
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _onGoToReservations(context);
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                const Align(child: SuccessBadge()),
                const SizedBox(height: AppSpacing.xl),
                Text(
                  'new_reservation_success_title'.tr(),
                  textAlign: TextAlign.center,
                  style: AppTextStyles.headingGold,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'new_reservation_booked'.tr(),
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodySecondary,
                ),
                const SizedBox(height: AppSpacing.xl),
                Align(
                  child: SuccessTimeCard(
                    startsAt: reservation.startsAt,
                    endsAt: reservation.endsAt,
                  ),
                ),
                const Spacer(),
                GoToReservationsButton(
                  onTap: () => _onGoToReservations(context),
                ),
                const SizedBox(height: AppSpacing.md),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
