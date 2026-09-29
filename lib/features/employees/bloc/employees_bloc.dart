import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';

import '../../../core/data/api_exception.dart';
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
    } on ApiException catch (e) {
      emit(EmployeesFailure(e.message));
    } catch (_) {
      emit(EmployeesFailure('employees_generic_error'.tr()));
    }
  }

  void _onCleared(EmployeesCleared event, Emitter<EmployeesState> emit) {
    _employees = [];
    emit(EmployeesInitial());
  }
}
