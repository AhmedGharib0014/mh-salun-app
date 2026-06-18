part of 'login_bloc.dart';

sealed class LoginEvent {}

/// Dispatched when the user submits the login form.
class LoginSubmitted extends LoginEvent {
  LoginSubmitted(this.email, this.password);

  final String email;
  final String password;
}
