import 'package:json_annotation/json_annotation.dart';

part 'resend_verification_request.g.dart';

/// Request body for `POST /auth/resend-verification`.
@JsonSerializable()
class ResendVerificationRequest {
  const ResendVerificationRequest({required this.email});

  factory ResendVerificationRequest.fromJson(Map<String, dynamic> json) =>
      _$ResendVerificationRequestFromJson(json);

  final String email;

  Map<String, dynamic> toJson() => _$ResendVerificationRequestToJson(this);
}
