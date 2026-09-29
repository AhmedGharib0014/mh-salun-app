import 'package:json_annotation/json_annotation.dart';

import 'app_update_type.dart';

part 'version_check_result.g.dart';

/// Response of `GET /app-versions/check` — tells the client whether it must or
/// should update before the running version is allowed to keep going.
@JsonSerializable(createToJson: false)
class VersionCheckResult {
  const VersionCheckResult({
    required this.updateType,
    required this.latestVersion,
    required this.minimumSupportedVersion,
    required this.storeUrl,
  });

  factory VersionCheckResult.fromJson(Map<String, dynamic> json) =>
      _$VersionCheckResultFromJson(json);

  /// Falls back to [AppUpdateType.none] if the server sends an unknown value,
  /// so a new enum case can never lock the user out unexpectedly.
  @JsonKey(unknownEnumValue: AppUpdateType.none)
  final AppUpdateType updateType;

  final String latestVersion;
  final String minimumSupportedVersion;
  final String storeUrl;
}
