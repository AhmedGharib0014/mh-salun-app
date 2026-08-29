import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../data/reservations_repository.dart';
import '../../model/booked_reservation.dart';
import '../../model/reservation_filter.dart';

part 'reservations_list_event.dart';
part 'reservations_list_state.dart';

/// Lists one slice (upcoming / past) of the guest's reservations, page by page.
///
/// One instance per tab — the tab owns it and passes its filter with the first
/// event, which the bloc then keeps for the following pages.
@injectable
class ReservationsListBloc
    extends Bloc<ReservationsListEvent, ReservationsListState> {
  ReservationsListBloc(this._repo) : super(ReservationsListInitial()) {
    on<ReservationsListRequested>(_onRequested);
    on<ReservationsListRefreshed>(_onRefreshed);
    on<ReservationsListNextPageRequested>(_onNextPageRequested);
  }

  final ReservationsRepository _repo;

  ReservationFilter? _filter;

  /// Page to ask for next, or null once the last page has been loaded.
  int? _nextPage = 0;

  List<BookedReservation> _items = [];

  Future<void> _onRequested(
    ReservationsListRequested event,
    Emitter<ReservationsListState> emit,
  ) async {
    _filter = event.filter;
    await _loadFirstPage(emit);
  }

  Future<void> _onRefreshed(
    ReservationsListRefreshed event,
    Emitter<ReservationsListState> emit,
  ) async {
    if (_filter == null) return;
    await _loadFirstPage(emit, silent: state is ReservationsListLoaded);
  }

  /// Loads page 0 and replaces whatever was listed before.
  ///
  /// [silent] keeps the current list on screen instead of flashing a spinner —
  /// used by pull-to-refresh, which shows its own indicator.
  Future<void> _loadFirstPage(
    Emitter<ReservationsListState> emit, {
    bool silent = false,
  }) async {
    if (!silent) emit(ReservationsListLoading());
    try {
      final page = await _repo.getMyReservations(filter: _filter!, page: 0);
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
      final next = await _repo.getMyReservations(filter: _filter!, page: page);
      _items = [..._items, ...next.content];
      _nextPage = next.nextPage;
      emit(ReservationsListLoaded(items: _items, hasNext: next.hasNext));
    } catch (_) {
      // The pages already listed stay on screen; the footer offers a retry.
      emit(current.copyWith(isLoadingMore: false, loadMoreFailed: true));
    }
  }

  String _messageKey(Object error) => error is DioException
      ? 'network_error'
      : 'reservations_generic_error';
}
