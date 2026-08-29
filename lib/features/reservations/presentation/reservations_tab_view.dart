import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mh_salun/core/di/injection.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/text_styles.dart';
import 'package:mh_salun/features/reservations/bloc/reservations_list/reservations_list_bloc.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/reservations/empty_reservations_state.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/reservations/reservations_tab.dart';

/// The reservations destination: upcoming and past, one tab each.
///
/// Only the past list is owned here — it has no reader outside this screen, so
/// it is loaded on first build and closed with the shell. The upcoming list
/// comes from above the router, shared with the home card.
class ReservationsTabView extends StatelessWidget {
  const ReservationsTabView({super.key, required this.onStartBooking});

  final VoidCallback onStartBooking;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<PastReservationsBloc>()..add(ReservationsListRefreshed()),
      child: SafeArea(
        bottom: false,
        child: DefaultTabController(
          length: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TabBar(
                labelColor: AppColors.primary,
                unselectedLabelColor: AppColors.onSurface,
                indicatorColor: AppColors.primary,
                labelStyle: AppTextStyles.bodyRegular.copyWith(
                  fontWeight: FontWeight.w700,
                ),
                unselectedLabelStyle: AppTextStyles.bodyRegular,
                tabs: [
                  Tab(text: 'reservations_tab_upcoming'.tr()),
                  Tab(text: 'reservations_tab_previous'.tr()),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    ReservationsTab<UpcomingReservationsBloc>(
                      emptyState: EmptyReservationsState(
                        icon: Icons.event_available_outlined,
                        titleKey: 'reservations_empty_upcoming_title',
                        subtitleKey: 'reservations_empty_upcoming_subtitle',
                        actionKey: 'home_book_button',
                        onActionTap: onStartBooking,
                      ),
                    ),
                    const ReservationsTab<PastReservationsBloc>(
                      emptyState: EmptyReservationsState(
                        icon: Icons.history,
                        titleKey: 'reservations_empty_previous_title',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
