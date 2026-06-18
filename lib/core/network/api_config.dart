/// Static networking configuration values.
///
/// Keep environment-specific values here so the rest of the app references
/// named constants instead of raw strings scattered across repositories.
class ApiConfig {
  ApiConfig._();

  // Local backend. On the Android emulator use 10.0.2.2 instead of localhost
  // to reach the host machine.
  static const String baseUrl = 'http://localhost:8080/api/v1';

  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
  static const Duration sendTimeout = Duration(seconds: 15);
}
