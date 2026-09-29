import 'package:json_annotation/json_annotation.dart';

/// How the client should react to the version check.
///
/// - [none]: client is up to date, do nothing.
/// - [soft]: an update is available; prompt but let the user dismiss.
/// - [hard]: the running version is below the minimum supported one; force the
///   user to update before continuing.
@JsonEnum()
enum AppUpdateType {
  @JsonValue('NONE')
  none,
  @JsonValue('SOFT')
  soft,
  @JsonValue('HARD')
  hard,
}
