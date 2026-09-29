part of 'resend_verification_bloc.dart';

sealed class ResendVerificationEvent {}

/// Dispatched when the user asks for a new verification email.
class ResendVerificationSubmitted extends ResendVerificationEvent {
  ResendVerificationSubmitted(this.email);

  final String email;
}
