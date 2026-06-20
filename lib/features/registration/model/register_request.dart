import 'package:json_annotation/json_annotation.dart';

part 'register_request.g.dart';

/// Request body for `POST /auth/register`.
@JsonSerializable()
class RegisterRequest {
  const RegisterRequest({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.age,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);

  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final int age;

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}
