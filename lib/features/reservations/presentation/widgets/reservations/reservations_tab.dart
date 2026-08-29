import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mh_salun/core/presentation/widgets/section_loading.dart';
import 'package:mh_salun/features/reservations/bloc/reservations_list/reservations_list_bloc.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/reservations/empty_reservations_state.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/reservations/reservation_list.dart';

/// One tab of the reservations screen, listing the slice held by [B].
///
/// The bloc is provided above the tab and outlives it, so the loaded pages
/// survive switching tabs — and the upcoming list is the same instance the
/// home card reads.
class ReservationsTab<B extends ReservationsListBloc> extends StatelessWidget {
  const ReservationsTab({super.key, required this.emptyState});

  /// Shown when the guest has no reservations in this slice — the copy and the
  /// call to action differ per tab.
  final EmptyReservationsState emptyState;

  /// Reloads page 0 and completes when the list settles, so the pull-to-refresh
  /// indicator stays up for the whole request.
  Future<void> _refresh(BuildContext context) {
    final bloc = context.read<B>();
    bloc.add(ReservationsListRefreshed());
    return bloc.stream
        .firstWhere((state) => state is! ReservationsListLoading)
        .then((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, ReservationsListState>(
      builder: (context, state) {
        switch (state) {
          case ReservationsListInitial() || ReservationsListLoading():
            return const SectionLoading(height: double.infinity);
          case ReservationsListFailure(:final messageKey):
            return EmptyReservationsState(
              icon: Icons.error_outline,
              titleKey: 'common_error_title',
              subtitleKey: messageKey,
              actionKey: 'reservations_retry',
              onActionTap: () =>
                  context.read<B>().add(ReservationsListRefreshed()),
            );
          case ReservationsListLoaded(:final items) when items.isEmpty:
            return emptyState;
          case ReservationsListLoaded():
            return ReservationList(
              reservations: state.items,
              hasNext: state.hasNext,
              isLoadingMore: state.isLoadingMore,
              loadMoreFailed: state.loadMoreFailed,
              onLoadMore: () =>
                  context.read<B>().add(ReservationsListNextPageRequested()),
              onRefresh: () => _refresh(context),
            );
        }
      },
    );
  }
}
