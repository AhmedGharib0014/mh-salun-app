import 'package:json_annotation/json_annotation.dart';

part 'available_slot.g.dart';

/// A single bookable slot returned by `POST /reservations/available-slots`.
@JsonSerializable()
class AvailableSlot {
  const AvailableSlot({
    required this.id,
    required this.startsAt,
    required this.endsAt,
  });

  factory AvailableSlot.fromJson(Map<String, dynamic> json) =>
      _$AvailableSlotFromJson(json);

  final String id;
  final DateTime startsAt;
  final DateTime endsAt;

  Map<String, dynamic> toJson() => _$AvailableSlotToJson(this);
}
