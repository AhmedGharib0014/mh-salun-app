part of 'reservations_list_bloc.dart';

sealed class ReservationsListEvent {}

/// Dispatched once by the tab to load its first page for [filter].
class ReservationsListRequested extends ReservationsListEvent {
  ReservationsListRequested(this.filter);

  final ReservationFilter filter;
}

/// Dispatched on pull-to-refresh and on retry after a failure — reloads page 0
/// for the filter the list was created with.
class ReservationsListRefreshed extends ReservationsListEvent {}

/// Dispatched when the guest scrolls near the end of the loaded pages.
class ReservationsListNextPageRequested extends ReservationsListEvent {}
