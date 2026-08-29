import 'package:json_annotation/json_annotation.dart';

part 'booked_reservation_item.g.dart';

/// One service of a booked reservation.
///
/// Everything but the id comes back null while the reservation's
/// `enrichmentStatus` is still `PENDING` — the backend fills those in
/// afterwards.
@JsonSerializable()
class BookedReservationItem {
  const BookedReservationItem({
    required this.catalogItemId,
    this.name,
    this.price,
    this.durationMinutes,
  });

  factory BookedReservationItem.fromJson(Map<String, dynamic> json) =>
      _$BookedReservationItemFromJson(json);

  final String catalogItemId;
  final String? name;
  final num? price;
  final int? durationMinutes;

  Map<String, dynamic> toJson() => _$BookedReservationItemToJson(this);
}
