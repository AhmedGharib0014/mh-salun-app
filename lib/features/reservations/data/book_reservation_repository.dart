import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../model/book_reservation_request.dart';
import '../model/booked_reservation.dart';

/// Data access for booking a reservation.
@lazySingleton
class BookReservationRepository {
  BookReservationRepository(this._dio);

  final Dio _dio;

  /// Calls `POST /reservations` for the slot the guest picked, and returns the
  /// reservation the backend created for it.
  Future<BookedReservation> book(String timeSlotId) async {
    final response = await _dio.post(
      '/reservations',
      data: BookReservationRequest(timeSlotId: timeSlotId).toJson(),
    );
    return BookedReservation.fromJson(response.data as Map<String, dynamic>);
  }
}
