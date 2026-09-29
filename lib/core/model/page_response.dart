import 'package:json_annotation/json_annotation.dart';

part 'page_response.g.dart';

/// One page of a paginated backend response.
///
/// The envelope is `{content, page, size, hasNext}` — the backend does not send
/// totals, so whether more pages exist is only known through [hasNext].
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
    required this.page,
    required this.size,
    required this.hasNext,
  });

  factory PageResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$PageResponseFromJson(json, fromJsonT);

  final List<T> content;

  /// Zero-based index of this page — the `page` query parameter that produced it.
  final int page;

  /// Requested page size — the `size` query parameter.
  final int size;

  /// Whether another page can be requested after this one.
  final bool hasNext;

  /// Page index to request next, or `null` when this is the last page.
  int? get nextPage => hasNext ? page + 1 : null;

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$PageResponseToJson(this, toJsonT);
}
