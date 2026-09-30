import 'package:json_annotation/json_annotation.dart';

part 'book_reservation_request.g.dart';

/// Request body of `POST /reservations`.
///
/// The slot identifies the booking — it already carries the employee, branch
/// and services resolved by the available-slots call. The device id tells the
/// backend which install the booking came from.
@JsonSerializable()
class BookReservationRequest {
  const BookReservationRequest({
    required this.timeSlotId,
    required this.deviceId,
  });

  factory BookReservationRequest.fromJson(Map<String, dynamic> json) =>
      _$BookReservationRequestFromJson(json);

  final String timeSlotId;
  final String deviceId;

  Map<String, dynamic> toJson() => _$BookReservationRequestToJson(this);
}
