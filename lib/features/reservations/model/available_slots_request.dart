import 'package:json_annotation/json_annotation.dart';

part 'available_slots_request.g.dart';

/// Request body for `POST /reservations/available-slots`.
@JsonSerializable()
class AvailableSlotsRequest {
  const AvailableSlotsRequest({
    required this.employeeId,
    required this.branchId,
    required this.catalogItemIds,
    required this.date,
  });

  factory AvailableSlotsRequest.fromJson(Map<String, dynamic> json) =>
      _$AvailableSlotsRequestFromJson(json);

  final String employeeId;
  final String branchId;
  final List<String> catalogItemIds;

  /// The day to resolve slots for. Serialized as a plain `yyyy-MM-dd` date,
  /// which is what the backend expects — not a full ISO timestamp.
  @JsonKey(toJson: _dateToJson, fromJson: _dateFromJson)
  final DateTime date;

  Map<String, dynamic> toJson() => _$AvailableSlotsRequestToJson(this);

  static String _dateToJson(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '${date.year}-$month-$day';
  }

  static DateTime _dateFromJson(String date) => DateTime.parse(date);
}
