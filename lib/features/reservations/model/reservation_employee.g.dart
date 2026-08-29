// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReservationEmployee _$ReservationEmployeeFromJson(Map<String, dynamic> json) =>
    ReservationEmployee(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
    );

Map<String, dynamic> _$ReservationEmployeeToJson(
  ReservationEmployee instance,
) => <String, dynamic>{
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'avatarUrl': instance.avatarUrl,
};
