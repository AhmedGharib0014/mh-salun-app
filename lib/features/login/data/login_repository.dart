import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../core/data/auth_exception.dart';
import '../../../core/data/token_storage.dart';
import '../model/login_request.dart';
import '../model/login_response.dart';

/// Data access for the login endpoint.
@lazySingleton
class LoginRepository {
  LoginRepository(this._dio, this._tokenStorage);

  final Dio _dio;
  final TokenStorage _tokenStorage;

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
