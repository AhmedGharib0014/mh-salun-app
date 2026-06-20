import 'package:json_annotation/json_annotation.dart';

part 'register_request.g.dart';

/// Request body for `POST /auth/register`.
@JsonSerializable(includeIfNull: false)
class RegisterRequest {
  const RegisterRequest({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    this.dateOfBirth,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);

  final String email;
  final String password;
  final String firstName;
  final String lastName;

  /// Optional ISO-8601 date (`yyyy-MM-dd`), e.g. `1994-05-21`.
  /// Omitted from the request body when null.
  final String? dateOfBirth;

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}
