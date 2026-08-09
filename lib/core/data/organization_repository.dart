import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../model/organization_response.dart';
import '../storage/local_storage.dart';

/// Data access for the organization endpoint.
@lazySingleton
class OrganizationRepository {
  OrganizationRepository(this._dio);

  final Dio _dio;

  static const _cacheKey = 'organization';

  /// Calls `GET /organizations`, caches the result locally, and returns the
  /// parsed response.
  Future<OrganizationResponse> getOrganization() async {
    final response = await _dio.get('/organizations');
    final result = OrganizationResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
    await LocalStorage.prefs.setString(_cacheKey, jsonEncode(result.toJson()));
    return result;
  }

  /// The last cached organization, or `null` if none has been fetched yet.
  OrganizationResponse? get cachedOrganization {
    final cached = LocalStorage.prefs.getString(_cacheKey);
    if (cached == null) return null;
    return OrganizationResponse.fromJson(
      jsonDecode(cached) as Map<String, dynamic>,
    );
  }
}
