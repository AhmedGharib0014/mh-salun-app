/// Static networking configuration values.
///
/// Keep environment-specific values here so the rest of the app references
/// named constants instead of raw strings scattered across repositories.
class ApiConfig {
  ApiConfig._();

  static const String baseUrl = 'https://api.example.com';

  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
  static const Duration sendTimeout = Duration(seconds: 15);
}
