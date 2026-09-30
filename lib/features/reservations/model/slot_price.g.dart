// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slot_price.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SlotPrice _$SlotPriceFromJson(Map<String, dynamic> json) => SlotPrice(
  timeSlotId: json['timeSlotId'] as String,
  servicesCost: json['servicesCost'] as num,
  appFee: json['appFee'] as num,
  total: json['total'] as num,
);

Map<String, dynamic> _$SlotPriceToJson(SlotPrice instance) => <String, dynamic>{
  'timeSlotId': instance.timeSlotId,
  'servicesCost': instance.servicesCost,
  'appFee': instance.appFee,
  'total': instance.total,
};
