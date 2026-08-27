import 'package:dio/dio.dart';

import '../data/auth_exception.dart';
import '../data/refresh_token_repository.dart';
import '../data/token_storage.dart';
import '../utils/app_logger.dart';
import 'api_config.dart';

Dio createDioClient() {
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

  final tokenStorage = TokenStorage();
  dio.interceptors.add(AuthInterceptor(tokenStorage));
  dio.interceptors.add(TokenRefreshInterceptor(dio, tokenStorage));
  dio.interceptors.add(DioLogInterceptor());

  return dio;
}

/// Attaches the persisted access token as a `Bearer` `Authorization` header
/// to every outgoing request, when one is available.
class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._tokenStorage);

  final TokenStorage _tokenStorage;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _tokenStorage.accessToken;
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}

class TokenRefreshInterceptor extends QueuedInterceptorsWrapper {
  TokenRefreshInterceptor(this._dio, TokenStorage tokenStorage)
    : _tokenStorage = tokenStorage,
      _refreshTokenRepository = RefreshTokenRepository(
        Dio(BaseOptions(baseUrl: ApiConfig.baseUrl))
          ..interceptors.add(DioLogInterceptor()),
        tokenStorage,
      );

  final Dio _dio;
  final TokenStorage _tokenStorage;
  final RefreshTokenRepository _refreshTokenRepository;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final isRefreshCall =
        err.requestOptions.path == RefreshTokenRepository.path;
    if (err.response?.statusCode != 401 || isRefreshCall) {
      return handler.next(err);
    }

    final refreshToken = _tokenStorage.refreshToken;
    if (refreshToken == null) {
      appLogger.w(
        '[TOKEN REFRESH] Got 401 on ${err.requestOptions.path} but no '
        'refresh token is stored — cannot refresh.',
      );
      return handler.next(err);
    }

    appLogger.w(
      '[TOKEN REFRESH] 401 on ${err.requestOptions.path} — attempting '
      'token refresh.',
    );
    try {
      final result = await _refreshTokenRepository.refresh(refreshToken);

      final retryOptions = err.requestOptions;
      retryOptions.headers['Authorization'] = 'Bearer ${result.accessToken}';
      final retryResponse = await _dio.fetch(retryOptions);
      handler.resolve(retryResponse);
    } on AuthException catch (e) {
      appLogger.w(
        '[TOKEN REFRESH] Refresh failed (${e.runtimeType}) — clearing tokens.',
      );
      await _tokenStorage.clearTokens();
      handler.next(err);
    }
  }
}
