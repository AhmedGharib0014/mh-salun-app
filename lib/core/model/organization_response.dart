import 'package:json_annotation/json_annotation.dart';

part 'organization_response.g.dart';

/// Success body for `GET /organizations`.
@JsonSerializable()
class OrganizationResponse {
  const OrganizationResponse({
    required this.id,
    required this.name,
    required this.tenantId,
    required this.bookingHorizonDays,
    required this.createdAt,
    this.logoUploadUrl,
    this.logoUrl,
  });

  factory OrganizationResponse.fromJson(Map<String, dynamic> json) =>
      _$OrganizationResponseFromJson(json);

  final String id;
  final String name;
  final String tenantId;
  final int bookingHorizonDays;
  final DateTime createdAt;
  final String? logoUploadUrl;
  final String? logoUrl;

  Map<String, dynamic> toJson() => _$OrganizationResponseToJson(this);
}
