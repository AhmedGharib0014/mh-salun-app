import 'package:json_annotation/json_annotation.dart';

import 'booked_reservation_item.dart';
import 'reservation_employee.dart';

part 'booked_reservation.g.dart';

/// A reservation of the signed-in guest.
///
/// Returned by `POST /reservations` (the reservation just created for a booked
/// slot) and as the page content of `GET /reservations/me`.
///
/// [employee] and [items] are filled in by the backend's enrichment step —
/// both are absent while [enrichmentStatus] is still `PENDING`, and the
/// booking response never carries [employee] at all. The pricing fields
/// ([servicesCost], [appFee], [totalPrice]) are filled in by the same step.
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
    this.servicesCost,
    this.appFee,
    this.totalPrice,
    this.items = const [],
    this.employee,
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

  /// Sum of the booked services' prices, or null before enrichment fills the
  /// pricing in.
  final num? servicesCost;

  /// The platform fee added on top of [servicesCost], or null before
  /// enrichment fills the pricing in.
  final num? appFee;

  /// What the guest pays — [servicesCost] plus [appFee] — or null before
  /// enrichment fills the pricing in.
  final num? totalPrice;

  /// The booked services. Null in the payload until the backend finishes
  /// enriching the reservation, which reads here as an empty list.
  @JsonKey(defaultValue: <BookedReservationItem>[])
  final List<BookedReservationItem> items;

  /// The employee the reservation is with, or null before enrichment fills it
  /// in — [employeeId] identifies them either way.
  final ReservationEmployee? employee;

  Map<String, dynamic> toJson() => _$BookedReservationToJson(this);
}
