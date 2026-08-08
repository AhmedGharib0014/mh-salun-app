import 'package:json_annotation/json_annotation.dart';

part 'catalog_item.g.dart';

/// A single item from `GET /catalog-items`.
@JsonSerializable()
class CatalogItem {
  const CatalogItem({
    required this.id,
    required this.organizationId,
    required this.name,
    required this.description,
    required this.price,
    required this.durationUnits,
    required this.bufferUnits,
    required this.category,
    required this.active,
    required this.hasIcon,
    required this.createdAt,
    required this.updatedAt,
    this.iconUploadUrl,
    this.iconUrl,
  });

  factory CatalogItem.fromJson(Map<String, dynamic> json) =>
      _$CatalogItemFromJson(json);

  final String id;
  final String organizationId;
  final String name;
  final String description;
  final double price;
  final int durationUnits;
  final int bufferUnits;
  final String category;
  final bool active;
  final bool hasIcon;
  final String? iconUploadUrl;
  final String? iconUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  Map<String, dynamic> toJson() => _$CatalogItemToJson(this);
}
