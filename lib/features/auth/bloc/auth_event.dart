part of 'auth_bloc.dart';

sealed class AuthEvent {}

/// Dispatched when the app starts (splash) to find out whether a stored
/// session exists.
class AuthCheckRequested extends AuthEvent {}

/// Dispatched when the user logs out.
class LogoutRequested extends AuthEvent {}
