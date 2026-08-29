import 'package:json_annotation/json_annotation.dart';

part 'reservation_employee.g.dart';

/// The employee a reservation is booked with, as returned inline with the
/// reservation.
///
/// The names come from the backend's enrichment step, so they can still be
/// null on a reservation it hasn't finished processing.
@JsonSerializable()
class ReservationEmployee {
  const ReservationEmployee({this.firstName, this.lastName, this.avatarUrl});

  factory ReservationEmployee.fromJson(Map<String, dynamic> json) =>
      _$ReservationEmployeeFromJson(json);

  final String? firstName;
  final String? lastName;
  final String? avatarUrl;

  /// Both names joined, or an empty string while neither has been filled in.
  String get fullName =>
      [firstName, lastName].whereType<String>().join(' ').trim();

  Map<String, dynamic> toJson() => _$ReservationEmployeeToJson(this);
}
