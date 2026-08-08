import 'package:json_annotation/json_annotation.dart';

part 'refresh_token_response.g.dart';

/// Success body for `POST /auth/refresh-token`.
@JsonSerializable()
class RefreshTokenResponse {
  const RefreshTokenResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
    required this.refreshExpiresIn,
    required this.tokenType,
  });

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenResponseFromJson(json);

  final String accessToken;
  final String refreshToken;

  /// Access-token lifetime in seconds.
  final int expiresIn;

  /// Refresh-token lifetime in seconds.
  final int refreshExpiresIn;

  /// Auth scheme for the `Authorization` header, e.g. `Bearer`.
  final String tokenType;

  Map<String, dynamic> toJson() => _$RefreshTokenResponseToJson(this);
}
