import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/text_styles.dart';
import 'package:mh_salun/features/reservations/model/reservation_filter.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/reservations/empty_reservations_state.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/reservations/reservations_tab.dart';

class ReservationsTabView extends StatelessWidget {
  const ReservationsTabView({super.key, required this.onStartBooking});

  final VoidCallback onStartBooking;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                  ReservationsTab(
                    filter: ReservationFilter.upcoming,
                    emptyState: EmptyReservationsState(
                      icon: Icons.event_available_outlined,
                      titleKey: 'reservations_empty_upcoming_title',
                      subtitleKey: 'reservations_empty_upcoming_subtitle',
                      actionKey: 'home_book_button',
                      onActionTap: onStartBooking,
                    ),
                  ),
                  const ReservationsTab(
                    filter: ReservationFilter.past,
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
    );
  }
}
