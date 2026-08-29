import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../data/reservations_repository.dart';
import '../../model/booked_reservation.dart';
import '../../model/reservation_filter.dart';

part 'reservations_list_event.dart';
part 'reservations_list_state.dart';

/// Lists one slice of the guest's reservations, page by page.
///
/// The slice is fixed at construction by the subclass, never by an event, so
/// an instance can only ever load the filter it was built for — the upcoming
/// list cannot be repointed at the past one and drop what the home card is
/// showing. The two subclasses also give the two instances distinct types, so
/// `context.read` resolves by type instead of by position in the widget tree.
abstract class ReservationsListBloc
    extends Bloc<ReservationsListEvent, ReservationsListState> {
  ReservationsListBloc(this._repo, this._filter)
    : super(ReservationsListInitial()) {
    on<ReservationsListRefreshed>(_onRefreshed);
    on<ReservationsListNextPageRequested>(_onNextPageRequested);
    on<ReservationsListCleared>(_onCleared);
  }

  final ReservationsRepository _repo;

  final ReservationFilter _filter;

  /// Page to ask for next, or null once the last page has been loaded.
  int? _nextPage = 0;

  List<BookedReservation> _items = [];

  /// Loads page 0 and replaces whatever was listed before.
  ///
  /// Keeps the current list on screen instead of flashing a spinner once
  /// something has been listed — pull-to-refresh shows its own indicator, and
  /// the home card must not blank out on a background refresh.
  Future<void> _onRefreshed(
    ReservationsListRefreshed event,
    Emitter<ReservationsListState> emit,
  ) async {
    if (state is! ReservationsListLoaded) emit(ReservationsListLoading());
    try {
      final page = await _repo.getMyReservations(filter: _filter, page: 0);
      _items = page.content;
      _nextPage = page.nextPage;
      emit(ReservationsListLoaded(items: _items, hasNext: page.hasNext));
    } catch (e) {
      emit(ReservationsListFailure(_messageKey(e)));
    }
  }

  Future<void> _onNextPageRequested(
    ReservationsListNextPageRequested event,
    Emitter<ReservationsListState> emit,
  ) async {
    final current = state;
    final page = _nextPage;
    // Ignore while a page is already in flight, and once the list is complete.
    if (current is! ReservationsListLoaded ||
        current.isLoadingMore ||
        page == null) {
      return;
    }

    emit(current.copyWith(isLoadingMore: true, loadMoreFailed: false));
    try {
      final next = await _repo.getMyReservations(filter: _filter, page: page);
      _items = [..._items, ...next.content];
      _nextPage = next.nextPage;
      emit(ReservationsListLoaded(items: _items, hasNext: next.hasNext));
    } catch (_) {
      // The pages already listed stay on screen; the footer offers a retry.
      emit(current.copyWith(isLoadingMore: false, loadMoreFailed: true));
    }
  }

  void _onCleared(
    ReservationsListCleared event,
    Emitter<ReservationsListState> emit,
  ) {
    _items = [];
    _nextPage = 0;
    emit(ReservationsListInitial());
  }

  String _messageKey(Object error) =>
      error is DioException ? 'network_error' : 'reservations_generic_error';
}

/// The guest's upcoming reservations.
///
/// Provided once above the router, so the home card, the upcoming tab and the
/// success page all read and refresh the same list.
@injectable
class UpcomingReservationsBloc extends ReservationsListBloc {
  UpcomingReservationsBloc(ReservationsRepository repo)
    : super(repo, ReservationFilter.upcoming);
}

/// The guest's past reservations — read only by its own tab.
@injectable
class PastReservationsBloc extends ReservationsListBloc {
  PastReservationsBloc(ReservationsRepository repo)
    : super(repo, ReservationFilter.past);
}
