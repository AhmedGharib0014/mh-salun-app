import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../model/employee.dart';

/// Data access for the workforce employees endpoint.
@lazySingleton
class EmployeeRepository {
  EmployeeRepository(this._dio);

  final Dio _dio;

  /// Calls `GET /workforce/employees` for the given organization and returns
  /// the parsed list of employees.
  Future<List<Employee>> getEmployees({required String orgId}) async {
    final response = await _dio.get(
      '/workforce/employees',
      queryParameters: {'orgId': orgId},
    );
    final data = response.data as List<dynamic>;
    return data
        .map((item) => Employee.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
