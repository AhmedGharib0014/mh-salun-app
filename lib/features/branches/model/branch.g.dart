// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Branch _$BranchFromJson(Map<String, dynamic> json) => Branch(
  id: json['id'] as String,
  organizationId: json['organizationId'] as String,
  name: json['name'] as String,
  location: BranchLocation.fromJson(json['location'] as Map<String, dynamic>),
  workingHours: (json['workingHours'] as Map<String, dynamic>).map(
    (k, e) =>
        MapEntry(k, BranchWorkingHours.fromJson(e as Map<String, dynamic>)),
  ),
  createdAt: DateTime.parse(json['createdAt'] as String),
  description: json['description'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  specialNote: json['specialNote'] as String?,
);

Map<String, dynamic> _$BranchToJson(Branch instance) => <String, dynamic>{
  'id': instance.id,
  'organizationId': instance.organizationId,
  'name': instance.name,
  'location': instance.location,
  'description': instance.description,
  'phoneNumber': instance.phoneNumber,
  'specialNote': instance.specialNote,
  'workingHours': instance.workingHours,
  'createdAt': instance.createdAt.toIso8601String(),
};
