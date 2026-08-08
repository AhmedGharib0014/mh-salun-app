import 'package:json_annotation/json_annotation.dart';

part 'employee_user.g.dart';

/// The `user` object nested in a `GET /workforce/employees` list item.
@JsonSerializable()
class EmployeeUser {
  const EmployeeUser({
    required this.userId,
    required this.firstName,
    required this.lastName,
    this.avatarUrl,
  });

  factory EmployeeUser.fromJson(Map<String, dynamic> json) =>
      _$EmployeeUserFromJson(json);

  final String userId;
  final String firstName;
  final String lastName;
  final String? avatarUrl;

  Map<String, dynamic> toJson() => _$EmployeeUserToJson(this);
}
