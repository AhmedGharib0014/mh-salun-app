import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/features/reservations/model/booked_reservation.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/reservations/load_more_footer.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/reservations/reservation_card.dart';

/// Distance from the bottom at which the next page starts loading, so the
/// guest rarely sees the footer spinner.
const double _loadMoreThreshold = 300;

/// Paginated list of reservations: pulls to refresh, and asks for the next
/// page as the end comes into view.
class ReservationList extends StatelessWidget {
  const ReservationList({
    super.key,
    required this.reservations,
    required this.hasNext,
    required this.isLoadingMore,
    required this.loadMoreFailed,
    required this.onLoadMore,
    required this.onRefresh,
  });

  final List<BookedReservation> reservations;
  final bool hasNext;
  final bool isLoadingMore;
  final bool loadMoreFailed;
  final VoidCallback onLoadMore;
  final Future<void> Function() onRefresh;

  bool _onScroll(ScrollNotification notification) {
    if (!hasNext || isLoadingMore || loadMoreFailed) return false;
    final metrics = notification.metrics;
    if (metrics.pixels >= metrics.maxScrollExtent - _loadMoreThreshold) {
      onLoadMore();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: NotificationListener<ScrollNotification>(
        onNotification: _onScroll,
        child: ListView.separated(
          padding: EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.md,
            AppSpacing.lg,
            AppSpacing.bottomNavClearance +
                MediaQuery.of(context).padding.bottom,
          ),
          // One extra slot for the footer once more pages remain.
          itemCount: reservations.length + (hasNext ? 1 : 0),
          separatorBuilder: (context, index) =>
              const SizedBox(height: AppSpacing.md),
          itemBuilder: (context, index) {
            if (index == reservations.length) {
              return LoadMoreFooter(failed: loadMoreFailed, onRetry: onLoadMore);
            }
            return ReservationCard(reservation: reservations[index]);
          },
        ),
      ),
    );
  }
}
