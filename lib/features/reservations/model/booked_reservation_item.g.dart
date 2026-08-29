// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booked_reservation_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookedReservationItem _$BookedReservationItemFromJson(
  Map<String, dynamic> json,
) => BookedReservationItem(
  catalogItemId: json['catalogItemId'] as String,
  name: json['name'] as String?,
  price: json['price'] as num?,
  durationMinutes: (json['durationMinutes'] as num?)?.toInt(),
);

Map<String, dynamic> _$BookedReservationItemToJson(
  BookedReservationItem instance,
) => <String, dynamic>{
  'catalogItemId': instance.catalogItemId,
  'name': instance.name,
  'price': instance.price,
  'durationMinutes': instance.durationMinutes,
};
