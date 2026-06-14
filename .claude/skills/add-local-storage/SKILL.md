---
name: add-local-storage
description: Read or write small key/value local data in the mh_salun Flutter app. Use when caching a token, id, flag, or user preference, or persisting a primitive across app launches. Covers the LocalStorage wrapper (lib/core/storage/local_storage.dart) over shared_preferences and the rule against calling SharedPreferences directly.
---

# Add local storage

Package: `shared_preferences`, wrapped by `LocalStorage`
(`lib/core/storage/local_storage.dart`). For small, **non-sensitive** key/value
data only — flags, ids, cached primitives, preferences. Not for secrets (use secure
storage) or large/structured data (use a database).

## Rules
- Access through `LocalStorage.prefs` — **never** call
  `SharedPreferences.getInstance()` anywhere else. The instance is initialized once
  via `LocalStorage.init()` in `lib/main.dart`.
- Reads/writes belong in the **local side of a repository**, not in UI or BLoC.
- Keep keys as constants in the repo that owns them.

## Use
```dart
import 'package:mh_salun/core/storage/local_storage.dart';

class AuthRepository {
  static const _tokenKey = 'auth_token';

  Future<void> saveToken(String token) =>
      LocalStorage.prefs.setString(_tokenKey, token);

  String? get token => LocalStorage.prefs.getString(_tokenKey);
}
```

Usually invoked from **add-repo** when a repo needs to persist a primitive.
