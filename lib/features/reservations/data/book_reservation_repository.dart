import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../core/data/api_exception.dart';
import '../../../core/data/device_id_storage.dart';
import '../model/book_reservation_request.dart';
import '../model/booked_reservation.dart';

/// Data access for booking a reservation.
@lazySingleton
class BookReservationRepository {
  BookReservationRepository(this._dio, this._deviceIdStorage);

  final Dio _dio;
  final DeviceIdStorage _deviceIdStorage;

  /// Calls `POST /reservations` for the slot the guest picked, and returns the
  /// reservation the backend created for it.
  Future<BookedReservation> book(String timeSlotId) async {
    try {
      final response = await _dio.post(
        '/reservations',
        data: BookReservationRequest(
          timeSlotId: timeSlotId,
          deviceId: await _deviceIdStorage.deviceId,
        ).toJson(),
      );
      return BookedReservation.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }
}
