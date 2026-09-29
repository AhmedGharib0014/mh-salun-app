part of 'resend_verification_bloc.dart';

sealed class ResendVerificationState {}

class ResendVerificationInitial extends ResendVerificationState {}

class ResendVerificationLoading extends ResendVerificationState {}

class ResendVerificationSuccess extends ResendVerificationState {}

class ResendVerificationFailure extends ResendVerificationState {
  ResendVerificationFailure(this.message);

  final String message;
}
