---
name: add-di-dependency
description: Register a class or third-party type with the dependency-injection container in the mh_salun Flutter app. Use when a repo/service/BLoC needs to be resolvable via getIt, when wiring constructor dependencies, or when "the type isn't registered". Covers get_it + injectable annotations, RegisterModule for third-party types, and build_runner codegen.
---

# Add a DI dependency

Packages: `get_it` (service locator) + `injectable` (annotations) + `build_runner`.

Config lives in `lib/core/di/`:
- `injection.dart` — `getIt` instance + `configureDependencies()` (called in `main()`)
- `register_module.dart` — `RegisterModule` (`@module`): registers third-party types
- `injection.config.dart` — **generated**, committed, never hand-edited

## Register your own class
Annotate it; the generator wires its constructor dependencies.
```dart
@injectable          // new instance per resolve
class FooService { FooService(this._dio); final Dio _dio; }

@lazySingleton       // single instance, created on first resolve
class AuthRepository { AuthRepository(this._dio); final Dio _dio; }

@LazySingleton(as: AuthRepository)   // bind interface -> implementation
class AuthRepositoryImpl implements AuthRepository { ... }
```

## Register a third-party type (one you can't annotate)
Add an accessor to `RegisterModule` in `register_module.dart`:
```dart
@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => createDioClient();
}
```

## Run codegen (required after adding/editing any annotation)
```bash
dart run build_runner build --delete-conflicting-outputs
```

## Resolve
```dart
final repo = getIt<AuthRepository>();
```
Resolve BLoCs/repos with only injectable deps via `getIt<T>()` rather than
constructing them inline.

## Checklist
- [ ] Class annotated (`@injectable` / `@lazySingleton` / `@LazySingleton(as:)`)
- [ ] Third-party types added to `RegisterModule`, not annotated directly
- [ ] Ran `build_runner`; committed updated `injection.config.dart`
