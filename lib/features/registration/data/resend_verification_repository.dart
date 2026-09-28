import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../core/data/auth_exception.dart';
import '../model/resend_verification_request.dart';

/// Data access for the resend-verification endpoint.
@lazySingleton
class ResendVerificationRepository {
  ResendVerificationRepository(this._dio);

  final Dio _dio;

  /// Calls `POST /auth/resend-verification` to re-send the verification email.
  ///
  /// The endpoint answers `204 No Content` on success, so nothing is returned.
  /// Throws [AuthException] when the request fails or the backend is
  /// unreachable.
  Future<void> resendVerification(String email) async {
    try {
      await _dio.post(
        '/auth/resend-verification',
        data: ResendVerificationRequest(email: email).toJson(),
      );
    } on DioException catch (e) {
      throw AuthException.fromDio(e);
    }
  }
}
