import 'package:flutter/material.dart';
import 'package:mh_salun/core/model/service.dart';

import 'catalog_item.dart';

extension CatalogItemX on CatalogItem {
  /// Maps this catalog item to the [Service] view model shared by the home
  /// and services screens. Falls back to a generic icon when [iconUrl] is
  /// null; the icon widget falls back further on load error.
  Service toService() {
    return Service(
      icon: Icons.content_cut,
      iconUrl: iconUrl,
      name: name,
      description: description,
      duration: '$durationUnits min',
      price: '\$${price.toStringAsFixed(2)}',
    );
  }
}
