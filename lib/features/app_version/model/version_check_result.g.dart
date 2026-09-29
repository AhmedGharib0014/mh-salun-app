// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version_check_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VersionCheckResult _$VersionCheckResultFromJson(Map<String, dynamic> json) =>
    VersionCheckResult(
      updateType: $enumDecode(
        _$AppUpdateTypeEnumMap,
        json['updateType'],
        unknownValue: AppUpdateType.none,
      ),
      latestVersion: json['latestVersion'] as String,
      minimumSupportedVersion: json['minimumSupportedVersion'] as String,
      storeUrl: json['storeUrl'] as String,
    );

const _$AppUpdateTypeEnumMap = {
  AppUpdateType.none: 'NONE',
  AppUpdateType.soft: 'SOFT',
  AppUpdateType.hard: 'HARD',
};
