import 'package:json_annotation/json_annotation.dart';

part 'refresh_token_request.g.dart';

/// Request body for `POST /auth/refresh-token`.
@JsonSerializable()
class RefreshTokenRequest {
  const RefreshTokenRequest({required this.refreshToken});

  factory RefreshTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenRequestFromJson(json);

  final String refreshToken;

  Map<String, dynamic> toJson() => _$RefreshTokenRequestToJson(this);
}
