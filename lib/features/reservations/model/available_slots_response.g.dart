// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'available_slots_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvailableSlotsResponse _$AvailableSlotsResponseFromJson(
  Map<String, dynamic> json,
) => AvailableSlotsResponse(
  offerId: json['offerId'] as String,
  employeeId: json['employeeId'] as String,
  date: DateTime.parse(json['date'] as String),
  slots: (json['slots'] as List<dynamic>)
      .map((e) => AvailableSlot.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$AvailableSlotsResponseToJson(
  AvailableSlotsResponse instance,
) => <String, dynamic>{
  'offerId': instance.offerId,
  'employeeId': instance.employeeId,
  'date': instance.date.toIso8601String(),
  'slots': instance.slots,
};
