import 'package:json_annotation/json_annotation.dart';

part 'branch_location.g.dart';

/// The `location` object nested in a branch from
/// `GET /organizations/{orgId}/branches`.
@JsonSerializable()
class BranchLocation {
  const BranchLocation({
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  factory BranchLocation.fromJson(Map<String, dynamic> json) =>
      _$BranchLocationFromJson(json);

  final String address;
  final double latitude;
  final double longitude;

  Map<String, dynamic> toJson() => _$BranchLocationToJson(this);
}
