---
name: add-repo
description: Create a repository (data-access class) for the mh_salun Flutter app. Use when building a client to call an API endpoint, adding remote/local data access for a feature, or wrapping Dio calls. Covers feature-first data/ placement, @injectable, constructor-injected Dio, ApiConfig, and the never-construct-your-own-Dio rule.
---

# Add a repository

Package: `dio`. Repos are the data-access layer, split by domain (no god repos).

## Rules
- A repo **never constructs its own `Dio`** — it receives the single shared
  instance by constructor injection. The DI container hands every repo the same `Dio`.
- Repos live at `lib/features/<feature>/data/<feature>_repository.dart` and are
  annotated `@injectable` (new instance per resolve) or `@lazySingleton` (single
  shared instance — typical for repos).
- **Never** call Dio from UI or BLoC — only from repos.
- Don't put base URL / timeouts inline; they live in
  `lib/core/network/api_config.dart` (`ApiConfig`) and the shared client at
  `lib/core/network/dio_client.dart`.
- Cross-cutting concerns (auth token, retries, error mapping) are Dio
  **interceptors** in `dio_client.dart`, not per-call code.

## Remote repo
```dart
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mh_salun/features/auth/data/user.dart';

@lazySingleton
class AuthRepository {
  AuthRepository(this._dio);

  final Dio _dio;

  Future<User> login(String email, String password) async {
    final response = await _dio.post(
      '/auth/login',
      data: {'email': email, 'password': password},
    );
    return User.fromJson(response.data as Map<String, dynamic>);
  }
}
```

## Composes
- Typed request/response models — invoke the **add-json-model** skill.
- Caching primitives (tokens, ids, flags) on the local side — invoke the
  **add-local-storage** skill.
- After annotating, register it — invoke the **add-di-dependency** skill and run
  `build_runner`.

## Bind an interface to an implementation (optional)
```dart
@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository { ... }
```
