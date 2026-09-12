part of 'profile_bloc.dart';

sealed class ProfileEvent {}

/// Dispatched when the account screen needs the profile loaded.
class ProfileRequested extends ProfileEvent {}

/// Dispatched on a new successful login to drop the previous session's
/// cached profile before the new one is loaded.
class ProfileCleared extends ProfileEvent {}
