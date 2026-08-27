// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchLocation _$BranchLocationFromJson(Map<String, dynamic> json) =>
    BranchLocation(
      address: json['address'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$BranchLocationToJson(BranchLocation instance) =>
    <String, dynamic>{
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
