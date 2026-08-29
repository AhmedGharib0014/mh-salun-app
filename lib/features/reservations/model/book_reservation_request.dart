import 'package:json_annotation/json_annotation.dart';

part 'book_reservation_request.g.dart';

/// Request body of `POST /reservations`.
///
/// The slot alone identifies the booking — it already carries the employee,
/// branch and services resolved by the available-slots call.
@JsonSerializable()
class BookReservationRequest {
  const BookReservationRequest({required this.timeSlotId});

  factory BookReservationRequest.fromJson(Map<String, dynamic> json) =>
      _$BookReservationRequestFromJson(json);

  final String timeSlotId;

  Map<String, dynamic> toJson() => _$BookReservationRequestToJson(this);
}
