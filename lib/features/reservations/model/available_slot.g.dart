// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'available_slot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvailableSlot _$AvailableSlotFromJson(Map<String, dynamic> json) =>
    AvailableSlot(
      id: json['id'] as String,
      startsAt: DateTime.parse(json['startsAt'] as String),
      endsAt: DateTime.parse(json['endsAt'] as String),
    );

Map<String, dynamic> _$AvailableSlotToJson(AvailableSlot instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startsAt': instance.startsAt.toIso8601String(),
      'endsAt': instance.endsAt.toIso8601String(),
    };
