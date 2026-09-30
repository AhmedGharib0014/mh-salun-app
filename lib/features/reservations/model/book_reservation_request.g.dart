// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_reservation_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookReservationRequest _$BookReservationRequestFromJson(
  Map<String, dynamic> json,
) => BookReservationRequest(
  timeSlotId: json['timeSlotId'] as String,
  deviceId: json['deviceId'] as String,
);

Map<String, dynamic> _$BookReservationRequestToJson(
  BookReservationRequest instance,
) => <String, dynamic>{
  'timeSlotId': instance.timeSlotId,
  'deviceId': instance.deviceId,
};
