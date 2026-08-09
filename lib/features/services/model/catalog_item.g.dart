// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CatalogItem _$CatalogItemFromJson(Map<String, dynamic> json) => CatalogItem(
  id: json['id'] as String,
  organizationId: json['organizationId'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  price: (json['price'] as num).toDouble(),
  durationUnits: (json['durationUnits'] as num).toInt(),
  bufferUnits: (json['bufferUnits'] as num).toInt(),
  category: json['category'] as String,
  active: json['active'] as bool,
  hasIcon: json['hasIcon'] as bool,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  iconUploadUrl: json['iconUploadUrl'] as String?,
  iconUrl: json['iconUrl'] as String?,
);

Map<String, dynamic> _$CatalogItemToJson(CatalogItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'organizationId': instance.organizationId,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'durationUnits': instance.durationUnits,
      'bufferUnits': instance.bufferUnits,
      'category': instance.category,
      'active': instance.active,
      'hasIcon': instance.hasIcon,
      'iconUploadUrl': instance.iconUploadUrl,
      'iconUrl': instance.iconUrl,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
