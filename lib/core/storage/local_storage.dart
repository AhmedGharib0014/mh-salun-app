import 'package:shared_preferences/shared_preferences.dart';

/// Single shared [SharedPreferences] instance for the whole app.
///
/// [LocalStorage.init] must be awaited once in `main()` before `runApp`, the
/// same way [EasyLocalization.ensureInitialized] is. After that, repositories
/// can read/write through [LocalStorage.prefs] (or the typed helpers below)
/// synchronously without re-awaiting `getInstance()` on every call.
class LocalStorage {
  LocalStorage._();

  static late final SharedPreferences _prefs;

  /// Initialize the shared instance. Call once, before `runApp`.
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// The underlying [SharedPreferences] for direct access when the typed
  /// helpers below aren't enough.
  static SharedPreferences get prefs => _prefs;
}
