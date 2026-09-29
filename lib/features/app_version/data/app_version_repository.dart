import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../core/data/api_exception.dart';
import '../model/version_check_result.dart';

/// Data access for the app version check endpoint.
@lazySingleton
class AppVersionRepository {
  AppVersionRepository(this._dio);

  final Dio _dio;

  /// Realm identifying this app to the versions service.
  static const String _realm = 'mhsalun';

  /// Calls `GET /app-versions/check` and returns whether the running [version]
  /// needs a soft or hard update.
  ///
  /// [platform] defaults to the current OS (`ANDROID` / `IOS`); pass it
  /// explicitly to override.
  Future<VersionCheckResult> checkVersion({
    required String version,
    String? platform,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/app-versions/check',
        queryParameters: {
          'realm': _realm,
          'platform': platform ?? _currentPlatform,
          'version': version,
        },
      );
      return VersionCheckResult.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  String get _currentPlatform => Platform.isIOS ? 'IOS' : 'ANDROID';
}
