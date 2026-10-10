import 'package:json_annotation/json_annotation.dart';

part 'slot_price.g.dart';

/// Response body of `GET /reservations/available-slots/{timeSlotId}/price`.
///
/// [total] is what the customer pays — [servicesCost] plus the platform's
/// [appFee].
@JsonSerializable()
class SlotPrice {
  const SlotPrice({
    required this.timeSlotId,
    required this.servicesCost,
    required this.appFee,
    required this.total,
  });

  factory SlotPrice.fromJson(Map<String, dynamic> json) =>
      _$SlotPriceFromJson(json);

  final String timeSlotId;
  final num servicesCost;
  final num appFee;
  final num total;

  Map<String, dynamic> toJson() => _$SlotPriceToJson(this);
}
