part of 'reservations_list_bloc.dart';

sealed class ReservationsListState {}

class ReservationsListInitial extends ReservationsListState {}

/// First page in flight — nothing to show yet.
class ReservationsListLoading extends ReservationsListState {}

class ReservationsListLoaded extends ReservationsListState {
  ReservationsListLoaded({
    required this.items,
    required this.hasNext,
    this.isLoadingMore = false,
    this.loadMoreFailed = false,
  });

  /// Every reservation loaded so far, across all fetched pages.
  final List<BookedReservation> items;

  /// Whether another page can still be loaded.
  final bool hasNext;

  final bool isLoadingMore;

  /// The last next-page fetch failed — the loaded items stay listed and the
  /// footer offers a retry.
  final bool loadMoreFailed;

  ReservationsListLoaded copyWith({bool? isLoadingMore, bool? loadMoreFailed}) {
    return ReservationsListLoaded(
      items: items,
      hasNext: hasNext,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      loadMoreFailed: loadMoreFailed ?? this.loadMoreFailed,
    );
  }
}

/// The first page failed — nothing is listed.
class ReservationsListFailure extends ReservationsListState {
  ReservationsListFailure(this.messageKey);

  final String messageKey;
}
