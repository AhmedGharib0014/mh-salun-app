import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../model/branch.dart';

/// Data access for the organization branches endpoint.
@lazySingleton
class BranchRepository {
  BranchRepository(this._dio);

  final Dio _dio;

  /// Calls `GET /organizations/{orgId}/branches` and returns the parsed list
  /// of branches for the given organization.
  Future<List<Branch>> getBranches({required String orgId}) async {
    final response = await _dio.get('/organizations/$orgId/branches');
    final data = response.data as List<dynamic>;
    return data
        .map((item) => Branch.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
