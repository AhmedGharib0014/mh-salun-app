part of 'reservations_list_bloc.dart';

sealed class ReservationsListEvent {}

/// Loads page 0 for the slice this bloc was built for, dropping the pages
/// already listed. Dispatched for the first load, on pull-to-refresh, on retry
/// after a failure, and whenever the list may have gone stale — the home tab
/// coming up, or a booking just confirmed.
class ReservationsListRefreshed extends ReservationsListEvent {}

/// Dispatched when the guest scrolls near the end of the loaded pages.
class ReservationsListNextPageRequested extends ReservationsListEvent {}

/// Drops everything listed. Dispatched on sign-out, so a list that outlives the
/// session does not carry the previous guest's reservations into the next one.
class ReservationsListCleared extends ReservationsListEvent {}
