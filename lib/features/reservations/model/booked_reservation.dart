import 'package:json_annotation/json_annotation.dart';

import 'booked_reservation_item.dart';

part 'booked_reservation.g.dart';

/// Response body of `POST /reservations` — the reservation the backend
/// created for the booked slot.
@JsonSerializable()
class BookedReservation {
  const BookedReservation({
    required this.reservationId,
    required this.employeeId,
    required this.branchId,
    required this.startsAt,
    required this.endsAt,
    required this.status,
    required this.enrichmentStatus,
    required this.items,
  });

  factory BookedReservation.fromJson(Map<String, dynamic> json) =>
      _$BookedReservationFromJson(json);

  final String reservationId;
  final String employeeId;
  final String branchId;
  final DateTime startsAt;
  final DateTime endsAt;

  /// Lifecycle of the reservation itself, e.g. `BOOKED`.
  final String status;

  /// Whether the backend has finished filling in the item details, e.g.
  /// `PENDING` — see [BookedReservationItem].
  final String enrichmentStatus;

  final List<BookedReservationItem> items;

  Map<String, dynamic> toJson() => _$BookedReservationToJson(this);
}
