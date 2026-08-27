import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

/// Success body for `GET /profiles/me`.
@JsonSerializable()
class Profile {
  const Profile({
    required this.userId,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.dateOfBirth,
    required this.createdAt,
    this.avatarUrl,
  });

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  final String userId;
  final String email;
  final String firstName;
  final String lastName;
  final DateTime? dateOfBirth;
  final DateTime createdAt;
  final String? avatarUrl;

  String get fullName => '$firstName $lastName';

  String get initials => '${firstName[0]}${lastName[0]}'.toUpperCase();

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
