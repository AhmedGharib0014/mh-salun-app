import 'package:json_annotation/json_annotation.dart';

import 'employee_user.dart';

part 'employee.g.dart';

/// A single item from `GET /workforce/employees`.
@JsonSerializable()
class Employee {
  const Employee({
    required this.id,
    required this.user,
    required this.orgId,
    required this.mainBranchId,
    required this.active,
    required this.ratingAvg,
    required this.ratingCount,
    required this.weeklyHours,
    required this.catalogItemIds,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);

  final String id;
  final EmployeeUser user;
  final String orgId;
  final String mainBranchId;
  final bool active;
  final double ratingAvg;
  final int ratingCount;
  final List<dynamic> weeklyHours;
  final List<String> catalogItemIds;
  final DateTime createdAt;
  final DateTime updatedAt;

  Map<String, dynamic> toJson() => _$EmployeeToJson(this);
}
