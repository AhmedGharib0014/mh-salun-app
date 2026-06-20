import 'package:json_annotation/json_annotation.dart';

part 'register_response.g.dart';

/// Success body for `POST /auth/register`.
@JsonSerializable()
class RegisterResponse {
  const RegisterResponse({
    required this.userId,
    required this.email,
    required this.emailVerified,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);

  final String userId;
  final String email;
  final bool emailVerified;

  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}
