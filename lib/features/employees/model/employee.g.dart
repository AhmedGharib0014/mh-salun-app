// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Employee _$EmployeeFromJson(Map<String, dynamic> json) => Employee(
  id: json['id'] as String,
  user: EmployeeUser.fromJson(json['user'] as Map<String, dynamic>),
  orgId: json['orgId'] as String,
  mainBranchId: json['mainBranchId'] as String,
  active: json['active'] as bool,
  ratingAvg: (json['ratingAvg'] as num).toDouble(),
  ratingCount: (json['ratingCount'] as num).toInt(),
  weeklyHours: json['weeklyHours'] as List<dynamic>,
  catalogItemIds: (json['catalogItemIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
  'id': instance.id,
  'user': instance.user,
  'orgId': instance.orgId,
  'mainBranchId': instance.mainBranchId,
  'active': instance.active,
  'ratingAvg': instance.ratingAvg,
  'ratingCount': instance.ratingCount,
  'weeklyHours': instance.weeklyHours,
  'catalogItemIds': instance.catalogItemIds,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};
