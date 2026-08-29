import 'package:json_annotation/json_annotation.dart';

part 'page_response.g.dart';

/// One page of a paginated backend response.
///
/// The backend returns Spring's page envelope — this keeps the fields the app
/// actually paginates on and ignores the rest (`pageable`, `sort`).
///
/// [T] is the element type of [content]; parse it with the element's own
/// `fromJson`:
///
/// ```dart
/// PageResponse.fromJson(
///   json,
///   (item) => Reservation.fromJson(item as Map<String, dynamic>),
/// );
/// ```
@JsonSerializable(genericArgumentFactories: true)
class PageResponse<T> {
  const PageResponse({
    required this.content,
    required this.number,
    required this.size,
    required this.totalElements,
    required this.totalPages,
    required this.first,
    required this.last,
    required this.numberOfElements,
    required this.empty,
  });

  factory PageResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$PageResponseFromJson(json, fromJsonT);

  final List<T> content;

  /// Zero-based index of this page — the `page` query parameter that produced it.
  final int number;

  /// Requested page size — the `size` query parameter.
  final int size;

  final int totalElements;
  final int totalPages;
  final bool first;
  final bool last;

  /// How many elements this page actually carries, which is at most [size].
  final int numberOfElements;

  final bool empty;

  /// Whether another page can be requested after this one.
  bool get hasNext => !last;

  /// Page index to request next, or `null` when this is the last page.
  int? get nextPage => hasNext ? number + 1 : null;

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$PageResponseToJson(this, toJsonT);
}
