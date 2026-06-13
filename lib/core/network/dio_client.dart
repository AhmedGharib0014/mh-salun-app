import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'api_config.dart';

/// Single shared [Dio] instance for the whole app.
///
/// Repositories should depend on [dioClient] rather than constructing their
/// own [Dio] — this keeps base URL, timeouts, and interceptors consistent.
final Dio dioClient = _createDio();

Dio _createDio() {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: ApiConfig.connectTimeout,
      receiveTimeout: ApiConfig.receiveTimeout,
      sendTimeout: ApiConfig.sendTimeout,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ),
  );

  if (kDebugMode) {
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: false,
        responseHeader: false,
      ),
    );
  }

  return dio;
}
