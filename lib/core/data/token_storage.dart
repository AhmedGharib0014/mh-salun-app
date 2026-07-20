import 'package:injectable/injectable.dart';

import '../storage/local_storage.dart';

/// Persisted auth tokens, shared across any feature that needs to read or
/// write them (e.g. login persists them, splash reads them to decide where
/// to navigate).
@lazySingleton
class TokenStorage {
  static const _accessTokenKey = 'auth_access_token';
  static const _refreshTokenKey = 'auth_refresh_token';

  /// The persisted access token, or `null` if not logged in.
  String? get accessToken => LocalStorage.prefs.getString(_accessTokenKey);

  /// The persisted refresh token, or `null` if not logged in.
  String? get refreshToken => LocalStorage.prefs.getString(_refreshTokenKey);

  /// Whether a user is currently logged in.
  bool get isLoggedIn => accessToken != null;

  /// Persists the given tokens (e.g. after a successful login).
  Future<void> persistTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await LocalStorage.prefs.setString(_accessTokenKey, accessToken);
    await LocalStorage.prefs.setString(_refreshTokenKey, refreshToken);
  }

  /// Clears persisted tokens (e.g. on logout).
  Future<void> clearTokens() async {
    await LocalStorage.prefs.remove(_accessTokenKey);
    await LocalStorage.prefs.remove(_refreshTokenKey);
  }
}
