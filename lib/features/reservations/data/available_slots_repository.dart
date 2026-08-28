import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../model/available_slots_request.dart';
import '../model/available_slots_response.dart';

/// Data access for the reservation available-slots endpoint.
@lazySingleton
class AvailableSlotsRepository {
  AvailableSlotsRepository(this._dio);

  final Dio _dio;

  /// Calls `POST /reservations/available-slots` for the given employee,
  /// branch and services on [date], and returns the resolved offer with its
  /// bookable slots.
  Future<AvailableSlotsResponse> getAvailableSlots({
    required String employeeId,
    required String branchId,
    required List<String> catalogItemIds,
    required DateTime date,
  }) async {
    final response = await _dio.post(
      '/reservations/available-slots',
      data: AvailableSlotsRequest(
        employeeId: employeeId,
        branchId: branchId,
        catalogItemIds: catalogItemIds,
        date: date,
      ).toJson(),
    );
    return AvailableSlotsResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}
