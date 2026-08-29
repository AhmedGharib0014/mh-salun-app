part of 'book_reservation_bloc.dart';

sealed class BookReservationEvent {}

/// Dispatched when the guest confirms the booking on the review step. The slot
/// is all the endpoint needs — it already carries the branch, barber and
/// services resolved earlier in the flow.
class BookReservationRequested extends BookReservationEvent {
  BookReservationRequested(this.timeSlotId);

  final String timeSlotId;
}
