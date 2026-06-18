/// Thrown by [AuthRepository] when an auth request fails with a known error.
///
/// Carries the human-readable [message] (from the backend's RFC 7807
/// `detail` field when available) so the BLoC/UI can surface it directly.
class AuthException implements Exception {
  const AuthException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => 'AuthException($statusCode): $message';
}
