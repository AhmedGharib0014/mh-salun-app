import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

/// Success body for `POST /auth/login`.
@JsonSerializable()
class LoginResponse {
  const LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
    required this.refreshExpiresIn,
    required this.tokenType,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  final String accessToken;
  final String refreshToken;

  /// Access-token lifetime in seconds.
  final int expiresIn;

  /// Refresh-token lifetime in seconds.
  final int refreshExpiresIn;

  /// Auth scheme for the `Authorization` header, e.g. `Bearer`.
  final String tokenType;

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
