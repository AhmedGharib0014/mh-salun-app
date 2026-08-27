import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../data/employee_repository.dart';
import '../model/employee.dart';

part 'employees_event.dart';
part 'employees_state.dart';

/// Shared app-wide bloc: employees are loaded once per organization and
/// reused across every screen that needs them (home, reservation flow, ...).
@lazySingleton
class EmployeesBloc extends Bloc<EmployeesEvent, EmployeesState> {
  EmployeesBloc(this._repo) : super(EmployeesInitial()) {
    on<EmployeesRequested>(_onRequested);
    on<EmployeesCleared>(_onCleared);
  }

  final EmployeeRepository _repo;

  /// Cached employees, kept independent of the bloc state so other flows
  /// (e.g. the booking cycle) can read them without listening for state.
  List<Employee> _employees = [];
  List<Employee> get employees => _employees;

  Future<void> _onRequested(
    EmployeesRequested event,
    Emitter<EmployeesState> emit,
  ) async {
    emit(EmployeesLoading());
    try {
      final employees = await _repo.getEmployees(orgId: event.orgId);
      _employees = employees;
      emit(EmployeesLoaded(employees));
    } on DioException catch (_) {
      emit(EmployeesFailure('network_error'));
    } catch (_) {
      emit(EmployeesFailure('employees_generic_error'));
    }
  }

  void _onCleared(EmployeesCleared event, Emitter<EmployeesState> emit) {
    _employees = [];
    emit(EmployeesInitial());
  }
}
