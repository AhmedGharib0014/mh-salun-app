import 'package:json_annotation/json_annotation.dart';

import 'available_slot.dart';

part 'available_slots_response.g.dart';

/// Response body of `POST /reservations/available-slots`.
///
/// [offerId] identifies the resolved offer the returned [slots] belong to —
/// it is what a subsequent booking call refers back to.
@JsonSerializable()
class AvailableSlotsResponse {
  const AvailableSlotsResponse({
    required this.offerId,
    required this.employeeId,
    required this.date,
    required this.slots,
  });

  factory AvailableSlotsResponse.fromJson(Map<String, dynamic> json) =>
      _$AvailableSlotsResponseFromJson(json);

  final String offerId;
  final String employeeId;
  final DateTime date;
  final List<AvailableSlot> slots;

  Map<String, dynamic> toJson() => _$AvailableSlotsResponseToJson(this);
}
