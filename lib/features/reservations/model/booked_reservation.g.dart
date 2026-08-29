// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booked_reservation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookedReservation _$BookedReservationFromJson(Map<String, dynamic> json) =>
    BookedReservation(
      reservationId: json['reservationId'] as String,
      employeeId: json['employeeId'] as String,
      branchId: json['branchId'] as String,
      startsAt: DateTime.parse(json['startsAt'] as String),
      endsAt: DateTime.parse(json['endsAt'] as String),
      status: json['status'] as String,
      enrichmentStatus: json['enrichmentStatus'] as String,
      items:
          (json['items'] as List<dynamic>?)
              ?.map(
                (e) =>
                    BookedReservationItem.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      employee: json['employee'] == null
          ? null
          : ReservationEmployee.fromJson(
              json['employee'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$BookedReservationToJson(BookedReservation instance) =>
    <String, dynamic>{
      'reservationId': instance.reservationId,
      'employeeId': instance.employeeId,
      'branchId': instance.branchId,
      'startsAt': instance.startsAt.toIso8601String(),
      'endsAt': instance.endsAt.toIso8601String(),
      'status': instance.status,
      'enrichmentStatus': instance.enrichmentStatus,
      'items': instance.items,
      'employee': instance.employee,
    };
