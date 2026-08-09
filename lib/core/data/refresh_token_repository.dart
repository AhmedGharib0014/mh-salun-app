import 'package:dio/dio.dart';

import '../model/refresh_token_request.dart';
import '../model/refresh_token_response.dart';
import 'auth_exception.dart';
import 'token_storage.dart';

/// Data access for the token-refresh endpoint.
///
/// Constructed directly (not via DI) with a bare [Dio] that has no
/// interceptors, so [TokenRefreshInterceptor] can call it without
/// recursing back into itself.
class RefreshTokenRepository {
  RefreshTokenRepository(this._dio, this._tokenStorage);

  static const path = '/auth/refresh-token';

  final Dio _dio;
  final TokenStorage _tokenStorage;

  /// Calls `POST /auth/refresh-token`, persists the returned tokens, and
  /// returns the parsed response.
  ///
  /// Throws [AuthException] on a failed refresh (e.g. expired refresh
  /// token) or when the backend is unreachable.
  Future<RefreshTokenResponse> refresh(String refreshToken) async {
    try {
      final response = await _dio.post(
        path,
        data: RefreshTokenRequest(refreshToken: refreshToken).toJson(),
      );
      final result = RefreshTokenResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
      await _tokenStorage.persistTokens(
        accessToken: result.accessToken,
        refreshToken: result.refreshToken,
      );
      return result;
    } on DioException catch (e) {
      throw AuthException.fromDio(e);
    }
  }
}
