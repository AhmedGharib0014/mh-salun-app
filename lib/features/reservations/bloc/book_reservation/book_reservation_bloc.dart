import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../data/book_reservation_repository.dart';
import '../../model/booked_reservation.dart';

part 'book_reservation_event.dart';
part 'book_reservation_state.dart';

/// Books the slot the guest confirmed on the review step. Scoped to one
/// reservation flow — a new instance per flow, so a previous booking never
/// leaks into the next one.
@injectable
class BookReservationBloc
    extends Bloc<BookReservationEvent, BookReservationState> {
  BookReservationBloc(this._repo) : super(BookReservationInitial()) {
    on<BookReservationRequested>(_onRequested);
  }

  final BookReservationRepository _repo;

  Future<void> _onRequested(
    BookReservationRequested event,
    Emitter<BookReservationState> emit,
  ) async {
    // Guard against a second tap while the first booking is still in flight —
    // it would book the same slot twice.
    if (state is BookReservationLoading) return;

    emit(BookReservationLoading());
    try {
      final reservation = await _repo.book(event.timeSlotId);
      emit(BookReservationSuccess(reservation));
    } on DioException catch (_) {
      emit(BookReservationFailure('network_error'));
    } catch (_) {
      emit(BookReservationFailure('new_reservation_book_error'));
    }
  }
}
