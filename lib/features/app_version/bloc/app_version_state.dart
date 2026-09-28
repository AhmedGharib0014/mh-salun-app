part of 'app_version_bloc.dart';

sealed class AppVersionState {}

/// The check has not run yet.
class AppVersionInitial extends AppVersionState {}

/// Waiting for the versions service to answer.
class AppVersionChecking extends AppVersionState {}

/// No blocking update — the app may continue its normal start-up. Emitted for
/// [AppUpdateType.none] and also when the check fails, so a flaky network never
/// locks the user out on the splash screen.
class AppVersionUpToDate extends AppVersionState {}

/// An update is available but optional. The user may update or continue.
class AppVersionSoftUpdate extends AppVersionState {
  AppVersionSoftUpdate({required this.storeUrl, required this.latestVersion});

  final String storeUrl;
  final String latestVersion;
}

/// The running build is below the minimum supported version. The user must
/// update before continuing.
class AppVersionHardUpdate extends AppVersionState {
  AppVersionHardUpdate({required this.storeUrl, required this.latestVersion});

  final String storeUrl;
  final String latestVersion;
}
