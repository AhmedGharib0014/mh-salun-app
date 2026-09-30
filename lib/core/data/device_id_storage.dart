import 'dart:io';
import 'dart:math';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import '../storage/local_storage.dart';

/// The device identifier sent with requests that need to tell one device apart
/// from another (e.g. `POST /reservations`).
///
/// iOS keeps its id in the keychain: `identifierForVendor` is reset once the
/// user deletes the app, while keychain items live outside the app container
/// and are handed back to the same bundle id on reinstall. The id is generated
/// once (seeded from `identifierForVendor` when it is available, so installs
/// from before this change keep the id they have been sending) and read from
/// the keychain ever after.
///
/// Android is unchanged: the build `id` reported by the platform. When neither
/// path yields anything — an unsupported platform, a keychain read that throws
/// — a random id is generated once and persisted in prefs, so the device at
/// least keeps the same id across launches. Resolved once per run and cached
/// in memory.
@lazySingleton
class DeviceIdStorage {
  DeviceIdStorage(this._deviceInfo, this._secureStorage);

  static const _generatedIdKey = 'device_generated_id';
  static const _keychainIdKey = 'device_id';

  /// `first_unlock_this_device` so the id survives app deletion but never
  /// leaves this device (no iCloud keychain sync) and can still be read
  /// before the app is brought to the foreground.
  static const _iosOptions = IOSOptions(
    accessibility: KeychainAccessibility.first_unlock_this_device,
  );

  final DeviceInfoPlugin _deviceInfo;
  final FlutterSecureStorage _secureStorage;

  String? _cached;

  /// The device id — keychain-backed on iOS, native on Android, otherwise the
  /// persisted generated one. Never empty, so booking can always send an id.
  Future<String> get deviceId async {
    final cached = _cached;
    if (cached != null) return cached;

    final resolved = Platform.isIOS
        ? await _iosId()
        : await _androidOrFallbackId();
    _cached = resolved;
    return resolved;
  }

  /// The keychain id, creating one on first run. Falls back to the prefs-backed
  /// generated id if the keychain is unreachable.
  Future<String> _iosId() async {
    try {
      final stored = await _secureStorage.read(
        key: _keychainIdKey,
        iOptions: _iosOptions,
      );
      if (stored != null && stored.isNotEmpty) return stored;

      final seed = await _vendorId();
      final id = seed.isNotEmpty ? seed : _randomUuidV4();
      await _secureStorage.write(
        key: _keychainIdKey,
        value: id,
        iOptions: _iosOptions,
      );
      return id;
    } catch (_) {
      return _generatedId();
    }
  }

  Future<String> _androidOrFallbackId() async {
    final native = await _nativeAndroidId();
    return native.isNotEmpty ? native : _generatedId();
  }

  Future<String> _vendorId() async {
    try {
      final info = await _deviceInfo.iosInfo;
      return info.identifierForVendor ?? '';
    } catch (_) {
      return '';
    }
  }

  Future<String> _nativeAndroidId() async {
    try {
      if (Platform.isAndroid) {
        final info = await _deviceInfo.androidInfo;
        return info.id;
      }
      return '';
    } catch (_) {
      return '';
    }
  }

  /// The id generated for this install, creating and persisting one on first
  /// use so it stays stable across launches.
  String _generatedId() {
    final stored = LocalStorage.prefs.getString(_generatedIdKey);
    if (stored != null && stored.isNotEmpty) return stored;

    final generated = _randomUuidV4();
    // Fire-and-forget: the write only matters for the next launch, and the
    // in-memory cache covers the rest of this run.
    LocalStorage.prefs.setString(_generatedIdKey, generated);
    return generated;
  }

  /// A random UUID v4, built here to avoid pulling in a uuid package.
  String _randomUuidV4() {
    final random = Random.secure();
    final bytes = List<int>.generate(16, (_) => random.nextInt(256));
    bytes[6] = (bytes[6] & 0x0f) | 0x40; // version 4
    bytes[8] = (bytes[8] & 0x3f) | 0x80; // variant 1
    final hex = bytes
        .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
        .join();
    return '${hex.substring(0, 8)}-${hex.substring(8, 12)}-'
        '${hex.substring(12, 16)}-${hex.substring(16, 20)}-'
        '${hex.substring(20)}';
  }
}
