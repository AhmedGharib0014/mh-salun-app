import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_request.g.dart';

/// Request body for `POST /auth/forgot-password`.
@JsonSerializable()
class ForgotPasswordRequest {
  const ForgotPasswordRequest({required this.email});

  factory ForgotPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordRequestFromJson(json);

  final String email;

  Map<String, dynamic> toJson() => _$ForgotPasswordRequestToJson(this);
}
