// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'available_slots_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvailableSlotsRequest _$AvailableSlotsRequestFromJson(
  Map<String, dynamic> json,
) => AvailableSlotsRequest(
  employeeId: json['employeeId'] as String,
  branchId: json['branchId'] as String,
  catalogItemIds: (json['catalogItemIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  date: AvailableSlotsRequest._dateFromJson(json['date'] as String),
);

Map<String, dynamic> _$AvailableSlotsRequestToJson(
  AvailableSlotsRequest instance,
) => <String, dynamic>{
  'employeeId': instance.employeeId,
  'branchId': instance.branchId,
  'catalogItemIds': instance.catalogItemIds,
  'date': AvailableSlotsRequest._dateToJson(instance.date),
};
