// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeUser _$EmployeeUserFromJson(Map<String, dynamic> json) => EmployeeUser(
  userId: json['userId'] as String,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  avatarUrl: json['avatarUrl'] as String?,
);

Map<String, dynamic> _$EmployeeUserToJson(EmployeeUser instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'avatarUrl': instance.avatarUrl,
    };
