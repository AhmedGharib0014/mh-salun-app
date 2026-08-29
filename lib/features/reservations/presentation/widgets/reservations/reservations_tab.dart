import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mh_salun/core/di/injection.dart';
import 'package:mh_salun/core/presentation/widgets/section_loading.dart';
import 'package:mh_salun/features/reservations/bloc/reservations_list/reservations_list_bloc.dart';
import 'package:mh_salun/features/reservations/model/reservation_filter.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/reservations/empty_reservations_state.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/reservations/reservation_list.dart';

/// One tab of the reservations screen: owns the bloc listing [filter], so each
/// tab loads and paginates its own slice independently.
class ReservationsTab extends StatefulWidget {
  const ReservationsTab({
    super.key,
    required this.filter,
    required this.emptyState,
  });

  final ReservationFilter filter;

  /// Shown when the guest has no reservations in this slice — the copy and the
  /// call to action differ per tab.
  final EmptyReservationsState emptyState;

  @override
  State<ReservationsTab> createState() => _ReservationsTabState();
}

class _ReservationsTabState extends State<ReservationsTab>
    with AutomaticKeepAliveClientMixin {
  // Keeps the loaded pages alive while the guest switches tabs, instead of
  // refetching page 0 every time.
  @override
  bool get wantKeepAlive => false;

  /// Reloads page 0 and completes when the list settles, so the pull-to-refresh
  /// indicator stays up for the whole request.
  Future<void> _refresh(BuildContext context) {
    final bloc = context.read<ReservationsListBloc>();
    bloc.add(ReservationsListRefreshed());
    return bloc.stream
        .firstWhere((state) => state is! ReservationsListLoading)
        .then((_) {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (_) =>
          getIt<ReservationsListBloc>()
            ..add(ReservationsListRequested(widget.filter)),
      child: BlocBuilder<ReservationsListBloc, ReservationsListState>(
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
                onActionTap: () => context.read<ReservationsListBloc>().add(
                  ReservationsListRefreshed(),
                ),
              );
            case ReservationsListLoaded(:final items) when items.isEmpty:
              return widget.emptyState;
            case ReservationsListLoaded():
              return ReservationList(
                reservations: state.items,
                hasNext: state.hasNext,
                isLoadingMore: state.isLoadingMore,
                loadMoreFailed: state.loadMoreFailed,
                onLoadMore: () => context.read<ReservationsListBloc>().add(
                  ReservationsListNextPageRequested(),
                ),
                onRefresh: () => _refresh(context),
              );
          }
        },
      ),
    );
  }
}
