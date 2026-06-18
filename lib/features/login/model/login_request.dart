import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

/// Request body for `POST /auth/login`.
@JsonSerializable()
class LoginRequest {
  const LoginRequest({required this.email, required this.password});

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  final String email;
  final String password;

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}
