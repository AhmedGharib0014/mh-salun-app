import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../core/storage/local_storage.dart';
import 'auth_exception.dart';
import 'login_request.dart';
import 'login_response.dart';

/// Data access for authentication endpoints.
@lazySingleton
class AuthRepository {
  AuthRepository(this._dio);

  final Dio _dio;

  static const _accessTokenKey = 'auth_access_token';
  static const _refreshTokenKey = 'auth_refresh_token';

  /// Calls `POST /auth/login`, persists the returned tokens, and returns the
  /// parsed response.
  ///
  /// Throws [AuthException] on a failed login (e.g. invalid credentials) or
  /// when the backend is unreachable.
  Future<LoginResponse> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: LoginRequest(email: email, password: password).toJson(),
      );
      final result =
          LoginResponse.fromJson(response.data as Map<String, dynamic>);
      await _persistTokens(result);
      return result;
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  /// The persisted access token, or `null` if not logged in.
  String? get accessToken => LocalStorage.prefs.getString(_accessTokenKey);

  /// The persisted refresh token, or `null` if not logged in.
  String? get refreshToken => LocalStorage.prefs.getString(_refreshTokenKey);

  /// Clears persisted tokens (e.g. on logout).
  Future<void> clearTokens() async {
    await LocalStorage.prefs.remove(_accessTokenKey);
    await LocalStorage.prefs.remove(_refreshTokenKey);
  }

  Future<void> _persistTokens(LoginResponse response) async {
    await LocalStorage.prefs.setString(_accessTokenKey, response.accessToken);
    await LocalStorage.prefs.setString(_refreshTokenKey, response.refreshToken);
  }

  /// Maps a [DioException] to a user-facing [AuthException], preferring the
  /// backend's RFC 7807 `detail` message when present.
  AuthException _mapError(DioException e) {
    final data = e.response?.data;
    if (data is Map<String, dynamic> && data['detail'] is String) {
      return AuthException(
        data['detail'] as String,
        statusCode: e.response?.statusCode,
      );
    }
    return AuthException(
      'Something went wrong. Please try again.',
      statusCode: e.response?.statusCode,
    );
  }
}
