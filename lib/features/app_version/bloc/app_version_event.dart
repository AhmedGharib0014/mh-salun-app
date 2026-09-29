part of 'app_version_bloc.dart';

sealed class AppVersionEvent {}

/// Dispatched at the start of the splash screen to ask the versions service
/// whether the running build must or should update before continuing.
class AppVersionCheckRequested extends AppVersionEvent {}
