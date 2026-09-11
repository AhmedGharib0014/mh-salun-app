import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../core/data/auth_exception.dart';
import '../model/forgot_password_request.dart';

/// Data access for the forgot-password (reset link) endpoint.
@lazySingleton
class ForgotPasswordRepository {
  ForgotPasswordRepository(this._dio);

  final Dio _dio;

  /// Calls `POST /auth/forgot-password` to email a reset link.
  ///
  /// The endpoint answers `204 No Content` on success, so nothing is returned.
  /// Throws [AuthException] when the request fails or the backend is
  /// unreachable.
  Future<void> requestResetLink(String email) async {
    try {
      await _dio.post(
        '/auth/forgot-password',
        data: ForgotPasswordRequest(email: email).toJson(),
      );
    } on DioException catch (e) {
      throw AuthException.fromDio(e);
    }
  }
}
