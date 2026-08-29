import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mh_salun/core/presentation/widgets/section_header.dart';
import 'package:mh_salun/core/presentation/widgets/section_loading.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/features/reservations/bloc/reservations_list/reservations_list_bloc.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/reservations/reservation_card.dart';

/// The guest's next reservation on the home tab.
///
/// Reads the same list as the upcoming tab, so the two never disagree, and
/// takes its first item — paging further in the tab does not disturb it. The
/// section is left out entirely when there is nothing upcoming: the book-now
/// card above already carries that prompt.
class UpcomingBookingCard extends StatelessWidget {
  const UpcomingBookingCard({super.key, required this.onSeeAllTap});

  final VoidCallback onSeeAllTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpcomingReservationsBloc, ReservationsListState>(
      builder: (context, state) {
        switch (state) {
          case ReservationsListInitial() || ReservationsListLoading():
            return const SectionLoading(height: 140);
          // The reservations tab reports the error; the home tab stays quiet
          // rather than showing a second one.
          case ReservationsListFailure():
            return const SizedBox.shrink();
          case ReservationsListLoaded(:final items) when items.isEmpty:
            return const SizedBox.shrink();
          case ReservationsListLoaded(:final items):
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SectionHeader(
                  titleKey: 'home_upcoming_title',
                  actionKey: 'home_see_all',
                  onActionTap: onSeeAllTap,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                  ),
                  child: ReservationCard(reservation: items.first),
                ),
              ],
            );
        }
      },
    );
  }
}
