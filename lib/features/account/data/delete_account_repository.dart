import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../core/data/auth_exception.dart';

/// Data access for the delete-account endpoint.
@lazySingleton
class DeleteAccountRepository {
  DeleteAccountRepository(this._dio);

  final Dio _dio;

  /// Calls `DELETE /auth/me` to permanently delete the signed-in account.
  ///
  /// The endpoint answers `204 No Content` on success, so nothing is returned.
  /// Throws [AuthException] when the request fails or the backend is
  /// unreachable.
  Future<void> deleteMyAccount() async {
    try {
      await _dio.delete('/auth/me');
    } on DioException catch (e) {
      throw AuthException.fromDio(e);
    }
  }
}
