part of 'employees_bloc.dart';

sealed class EmployeesEvent {}

/// Dispatched when the home screen needs employees loaded for an organization.
class EmployeesRequested extends EmployeesEvent {
  EmployeesRequested(this.orgId);

  final String orgId;
}

/// Dispatched on a new successful login to drop the previous organization's
/// cached employees before the new one is loaded.
class EmployeesCleared extends EmployeesEvent {}
