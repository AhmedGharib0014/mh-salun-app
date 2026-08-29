import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../core/model/page_response.dart';
import '../model/booked_reservation.dart';
import '../model/reservation_filter.dart';

/// Default number of reservations fetched per page.
const int kReservationsPageSize = 20;

/// Data access for the signed-in guest's reservations.
@lazySingleton
class ReservationsRepository {
  ReservationsRepository(this._dio);

  final Dio _dio;

  /// Calls `GET /reservations/me` for the given [filter] and returns one page
  /// of reservations.
  ///
  /// [page] is zero-based; pass [PageResponse.nextPage] of the previous page to
  /// load the next one.
  Future<PageResponse<BookedReservation>> getMyReservations({
    required ReservationFilter filter,
    int page = 0,
    int size = kReservationsPageSize,
  }) async {
    final response = await _dio.get(
      '/reservations/me',
      queryParameters: {
        'filter': filter.wireValue,
        'page': page,
        'size': size,
      },
    );
    return PageResponse.fromJson(
      response.data as Map<String, dynamic>,
      (item) => BookedReservation.fromJson(item as Map<String, dynamic>),
    );
  }
}
