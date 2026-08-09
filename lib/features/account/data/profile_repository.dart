import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../core/storage/local_storage.dart';
import '../model/profile.dart';

/// Data access for the profile endpoint.
@lazySingleton
class ProfileRepository {
  ProfileRepository(this._dio);

  final Dio _dio;

  static const _cacheKey = 'profile';

  /// Returns the cached profile if one exists; otherwise calls
  /// `GET /profiles/me`, caches the result locally, and returns it.
  Future<Profile> getMyProfile() async {
    final cached = cachedProfile;
    if (cached != null) return cached;

    final response = await _dio.get('/profiles/me');
    final result = Profile.fromJson(response.data as Map<String, dynamic>);
    await LocalStorage.prefs.setString(_cacheKey, jsonEncode(result.toJson()));
    return result;
  }

  /// The last cached profile, or `null` if none has been fetched yet.
  Profile? get cachedProfile {
    final cached = LocalStorage.prefs.getString(_cacheKey);
    if (cached == null) return null;
    return Profile.fromJson(jsonDecode(cached) as Map<String, dynamic>);
  }

  /// Drops the cached profile so the next fetch hits the network.
  Future<void> clearProfile() => LocalStorage.prefs.remove(_cacheKey);
}
