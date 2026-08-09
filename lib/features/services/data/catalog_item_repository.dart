import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../model/catalog_item.dart';

/// Data access for the catalog items endpoint.
@lazySingleton
class CatalogItemRepository {
  CatalogItemRepository(this._dio);

  final Dio _dio;

  /// Calls `GET /catalog-items` for the given organization and returns the
  /// parsed list of catalog items.
  Future<List<CatalogItem>> getCatalogItems({
    required String organizationId,
  }) async {
    final response = await _dio.get(
      '/catalog-items',
      queryParameters: {'organizationId': organizationId},
    );
    final data = response.data as List<dynamic>;
    return data
        .map((item) => CatalogItem.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
