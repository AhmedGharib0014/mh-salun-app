part of 'auth_bloc.dart';

sealed class AuthState {}

/// The session has not been checked yet.
class AuthInitial extends AuthState {}

/// A stored session exists.
class Authenticated extends AuthState {}

/// No session — either none was stored, or the user just logged out.
class Unauthenticated extends AuthState {}
