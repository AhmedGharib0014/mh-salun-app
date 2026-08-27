import 'package:json_annotation/json_annotation.dart';

import 'branch_location.dart';
import 'branch_working_hours.dart';

part 'branch.g.dart';

/// A single item from `GET /organizations/{orgId}/branches`.
@JsonSerializable()
class Branch {
  const Branch({
    required this.id,
    required this.organizationId,
    required this.name,
    required this.location,
    required this.workingHours,
    required this.createdAt,
    this.description,
    this.phoneNumber,
    this.specialNote,
  });

  factory Branch.fromJson(Map<String, dynamic> json) => _$BranchFromJson(json);

  final String id;
  final String organizationId;
  final String name;
  final BranchLocation location;
  final String? description;
  final String? phoneNumber;
  final String? specialNote;

  /// Keyed by upper-case day name, e.g. `MONDAY`. Missing keys mean closed.
  final Map<String, BranchWorkingHours> workingHours;

  final DateTime createdAt;

  /// First letter of the branch name, used as an avatar fallback (no logo).
  String get initial {
    final trimmed = name.trim();
    return trimmed.isEmpty ? '?' : trimmed.substring(0, 1).toUpperCase();
  }

  /// External maps destination for this branch, built from the exact
  /// coordinates of its [location].
  Uri get mapsUri {
    final query = Uri.encodeComponent(
      '${location.latitude},${location.longitude}',
    );
    return Uri.parse('https://www.google.com/maps/search/?api=1&query=$query');
  }

  Map<String, dynamic> toJson() => _$BranchToJson(this);
}
