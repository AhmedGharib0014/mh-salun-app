import 'package:dio/dio.dart';

/// Thrown by the auth repositories when a request fails with a known error.
///
/// Carries the human-readable [message] (from the backend's RFC 7807
/// `detail` field when available) so the BLoC/UI can surface it directly.
class AuthException implements Exception {
  const AuthException(this.message, {this.statusCode});

  /// Maps a [DioException] to a user-facing [AuthException], preferring the
  /// backend's RFC 7807 `detail` message when present.
  factory AuthException.fromDio(DioException e) {
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

  final String message;
  final int? statusCode;

  @override
  String toString() => 'AuthException($statusCode): $message';
}
