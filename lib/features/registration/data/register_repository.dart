import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../core/data/auth_exception.dart';
import '../model/register_request.dart';
import '../model/register_response.dart';

/// Data access for the registration endpoint.
@lazySingleton
class RegisterRepository {
  RegisterRepository(this._dio);

  final Dio _dio;

  /// Calls `POST /auth/register` and returns the parsed response.
  ///
  /// Throws [AuthException] when the email is already registered (HTTP 409) or
  /// when the backend is unreachable.
  Future<RegisterResponse> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required int age,
  }) async {
    try {
      final response = await _dio.post(
        '/auth/register',
        data: RegisterRequest(
          email: email,
          password: password,
          firstName: firstName,
          lastName: lastName,
          age: age,
        ).toJson(),
      );
      return RegisterResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw AuthException.fromDio(e);
    }
  }
}
