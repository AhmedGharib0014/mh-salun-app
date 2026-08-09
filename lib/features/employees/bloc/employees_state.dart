part of 'employees_bloc.dart';

sealed class EmployeesState {}

class EmployeesInitial extends EmployeesState {}

class EmployeesLoading extends EmployeesState {}

class EmployeesLoaded extends EmployeesState {
  EmployeesLoaded(this.employees);

  final List<Employee> employees;
}

class EmployeesFailure extends EmployeesState {}
