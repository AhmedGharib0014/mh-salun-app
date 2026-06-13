import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

final appLogger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 80,
    colors: true,
    printEmojis: true,
    dateTimeFormat: DateTimeFormat.none,
  ),
  level: kDebugMode ? Level.trace : Level.off,
);

class DioLogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    appLogger.d('[${options.method}] ${options.path}\n${options.data ?? ''}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    appLogger.i(
      '[${response.statusCode}] ${response.requestOptions.path}\n${response.data}',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    appLogger.e(
      '[ERROR] ${err.requestOptions.path}',
      error: err.error,
      stackTrace: err.stackTrace,
    );
    handler.next(err);
  }
}
