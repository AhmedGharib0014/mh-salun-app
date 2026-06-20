import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../core/data/auth_exception.dart';
import '../../../core/storage/local_storage.dart';
import '../model/login_request.dart';
import '../model/login_response.dart';

/// Data access for the login endpoint and persisted auth tokens.
@lazySingleton
class LoginRepository {
  LoginRepository(this._dio);

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
      final result = LoginResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
      await _persistTokens(result);
      return result;
    } on DioException catch (e) {
      throw AuthException.fromDio(e);
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
}
