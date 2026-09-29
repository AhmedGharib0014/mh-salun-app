import 'package:dio/dio.dart';

/// Thrown by repositories when an API request fails with a known error.
///
/// Carries a human-readable [message] extracted from the backend's error
/// body (RFC 7807 `detail`, validation lists, or common fallback keys) so the
/// BLoC/UI can surface it directly to the user.
class ApiException implements Exception {
  const ApiException(this.message, {this.statusCode});

  /// Maps a [DioException] to a user-facing [ApiException].
  ///
  /// Prefers a message parsed from the response body; otherwise falls back to
  /// a connectivity-aware message based on the [DioExceptionType].
  factory ApiException.fromDio(DioException e) {
    final parsed = _extractMessage(e.response?.data);
    if (parsed != null) {
      return ApiException(parsed, statusCode: e.response?.statusCode);
    }
    return ApiException(
      _fallbackForType(e.type),
      statusCode: e.response?.statusCode,
    );
  }

  final String message;
  final int? statusCode;

  /// Pulls the best available human-readable message out of an error body.
  ///
  /// Handles the backend's shapes, in order of preference:
  /// - `{"detail": "message"}` — RFC 7807 string detail.
  /// - `{"detail": [{"msg": "..."}]}` — FastAPI-style validation errors.
  /// - `{"message": "..."}` / `{"error": "..."}` — common fallback keys.
  /// - a bare string body.
  static String? _extractMessage(dynamic data) {
    if (data is Map) {
      final detail = data['detail'];
      if (detail is String && detail.trim().isNotEmpty) return detail.trim();
      if (detail is List && detail.isNotEmpty) {
        final messages = detail
            .whereType<Map>()
            .map((entry) => entry['msg'])
            .whereType<String>()
            .map((msg) => msg.trim())
            .where((msg) => msg.isNotEmpty)
            .toList();
        if (messages.isNotEmpty) return messages.join('\n');
      }
      for (final key in const ['message', 'error']) {
        final value = data[key];
        if (value is String && value.trim().isNotEmpty) return value.trim();
      }
    }
    if (data is String && data.trim().isNotEmpty) return data.trim();
    return null;
  }

  static String _fallbackForType(DioExceptionType type) {
    switch (type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'The connection timed out. Please try again.';
      case DioExceptionType.connectionError:
        return 'Cannot reach the server. Please check your connection.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }

  @override
  String toString() => 'ApiException($statusCode): $message';
}
