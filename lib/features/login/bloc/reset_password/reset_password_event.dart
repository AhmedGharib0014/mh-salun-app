part of 'reset_password_bloc.dart';

sealed class ResetPasswordEvent {}

/// Dispatched when the user asks for a password-reset link.
class ResetPasswordSubmitted extends ResetPasswordEvent {
  ResetPasswordSubmitted(this.email);

  final String email;
}
