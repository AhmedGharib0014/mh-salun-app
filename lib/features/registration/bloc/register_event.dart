part of 'register_bloc.dart';

sealed class RegisterEvent {}

/// Dispatched when the user submits the registration form.
class RegisterSubmitted extends RegisterEvent {
  RegisterSubmitted({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    this.dateOfBirth,
  });

  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final DateTime? dateOfBirth;
}
