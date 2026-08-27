import 'package:json_annotation/json_annotation.dart';

part 'branch_working_hours.g.dart';

/// A single day's opening/closing window inside a branch's `workingHours`
/// map from `GET /organizations/{orgId}/branches`.
@JsonSerializable()
class BranchWorkingHours {
  const BranchWorkingHours({
    required this.openingTime,
    required this.closingTime,
  });

  factory BranchWorkingHours.fromJson(Map<String, dynamic> json) =>
      _$BranchWorkingHoursFromJson(json);

  final String openingTime;
  final String closingTime;

  Map<String, dynamic> toJson() => _$BranchWorkingHoursToJson(this);
}
