// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrganizationResponse _$OrganizationResponseFromJson(
  Map<String, dynamic> json,
) => OrganizationResponse(
  id: json['id'] as String,
  name: json['name'] as String,
  tenantId: json['tenantId'] as String,
  bookingHorizonDays: (json['bookingHorizonDays'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  logoUploadUrl: json['logoUploadUrl'] as String?,
  logoUrl: json['logoUrl'] as String?,
);

Map<String, dynamic> _$OrganizationResponseToJson(
  OrganizationResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'tenantId': instance.tenantId,
  'bookingHorizonDays': instance.bookingHorizonDays,
  'createdAt': instance.createdAt.toIso8601String(),
  'logoUploadUrl': instance.logoUploadUrl,
  'logoUrl': instance.logoUrl,
};
