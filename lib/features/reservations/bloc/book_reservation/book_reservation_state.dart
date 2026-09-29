part of 'book_reservation_bloc.dart';

sealed class BookReservationState {}

class BookReservationInitial extends BookReservationState {}

class BookReservationLoading extends BookReservationState {}

class BookReservationSuccess extends BookReservationState {
  BookReservationSuccess(this.reservation);

  final BookedReservation reservation;
}

class BookReservationFailure extends BookReservationState {
  BookReservationFailure(this.message);

  /// User-facing, display-ready text for the error dialog.
  final String message;
}
