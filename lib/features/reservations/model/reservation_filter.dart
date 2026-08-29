import 'package:json_annotation/json_annotation.dart';

/// The `filter` query parameter of `GET /reservations/me` — which slice of the
/// guest's reservations to list.
enum ReservationFilter {
  @JsonValue('UPCOMING')
  upcoming('UPCOMING'),

  @JsonValue('PAST')
  past('PAST');

  const ReservationFilter(this.wireValue);

  /// Value the backend expects in the query string.
  final String wireValue;
}
