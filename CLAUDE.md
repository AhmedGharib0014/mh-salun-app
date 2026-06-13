# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.


## Project Overview

**mh_salun** is a Flutter application supporting multiple platforms (iOS, Android). 

## Architecture

3-layer architecture — no clean arch, no unnecessary abstractions.

### Layers
- **UI** — widgets, screens, any ui related staff
- **BLoC** — state management (bloc package), event-driven
- **Repository** — data access, splits into local (if needed) and remote internally

### Rules
- Skip BLoC if state doesn't survive navigation and isn't shared across widgets and call repo directly from UI
- BLoC is added when: state survives navigation, or is shared across multiple widgets, or has complex transitions or state manipulation needed
- Repos are split by domain — no god repo objects


### Packages
- State management: `bloc` + `flutter_bloc`
- Navigation: `go_router`
- Networking: `dio`
- JSON: `json_annotation` + `json_serializable` (codegen via `build_runner`)

### Testing
- no unit, integration or e2e test needed for this app 
- manual test only will be done by the developer

## Folder Architecture

Common Flutter structures:

- **Layer-first**: top-level `data/`, `domain/`, `presentation/`, `core/`. Features scattered across layers. Only viable for small apps.
- **Feature-first**: `features/<name>/{data,domain,presentation}` + `core/` + `shared/`. Each feature self-contained. Default choice for non-trivial apps.
- **Melos modular**: each feature is its own Dart package. Compile-enforced boundaries. High tooling cost; justified only by multi-team or hard-isolation needs.

**Decision: feature-first.** Layer-first for throwaway only; melos when compile-time isolation is genuinely required.

Open boundary rules to settle per project:
- Strictness of inter-layer dependency rule
- Whether anemic features collapse `domain/`
- Promotion rule for moving code into `shared/` (guard against `core/` becoming a junk drawer)
```


```markdown
## Responsive Sizing Strategy (Mobile-only, v1)

We do NOT use proportional/screen-scaling libraries (e.g. flutter_screenutil). 
No `.w`, `.h`, `.sp`, no width-ratio math for sizing.

### Fixed design tokens
Spacing, font sizes, icon sizes, and border radii are fixed constants — same value 
on every device. They don't need to scale; 16px padding looks correct whether the 
screen is 320pt or 430pt wide.

Define these in `lib/core/theme/spacing.dart` and `lib/core/theme/font_sizes.dart`:

```dart
class AppSpacing {
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
}

class AppFontSize {
  static const caption = 12.0;
  static const body = 14.0;
  static const title = 18.0;
  static const heading = 24.0;
}
```

Always reference these constants. Never hardcode raw numbers for padding/margin/fontSize 
in widgets.

### Layout adaptation via flex widgets
Screen-width differences are absorbed by `Expanded`, `Flexible`, and `FractionallySizedBox` 
— not by computing pixel values. Define ratios/proportions, let Flutter compute actual 
pixels at layout time.

```dart
// Proportional split — adapts to any width automatically
Row(
  children: [
    Expanded(flex: 2, child: ProductImage()),
    Expanded(flex: 3, child: ProductDetails()),
  ],
)

// Percentage of available width
FractionallySizedBox(
  widthFactor: 0.9,
  child: TextField(...),
)
```

### MediaQuery — minimal use only
Only for: safe area handling, keyboard insets, and rare small-screen conditionals 
(e.g. `if (MediaQuery.of(context).size.height < 700) ...`). Do not build a sizing 
abstraction layer around MediaQuery.

### Rule of thumb
- "Should this look the same everywhere?" → fixed token (spacing, font size, radius, icon size)
- "Should this adapt to available space?" → flex/fractional widget (layout proportions, widths)

### Out of scope for v1
No breakpoints, no tablet/desktop layouts, no adaptive scaffolds. Will be introduced 
when tablet/desktop support is added — retrofitted around real layout decisions, 
not the token values above.
```

## Localization

Package: `easy_localization ^3.0.7` + `flutter_localizations` (Flutter SDK)

**Supported locales:** `ar` (Arabic — default & fallback), `en` (English)

**Translation files:** `assets/translations/{locale}.json`
- `assets/translations/ar.json` — Arabic strings
- `assets/translations/en.json` — English strings

**Setup in `main.dart`:**
- `main()` calls `EasyLocalization.ensureInitialized()` before `runApp`
- Root widget is wrapped with `EasyLocalization(supportedLocales, path, fallbackLocale)`
- `MaterialApp` receives `context.localizationDelegates`, `context.supportedLocales`, and `context.locale`

**Using translations in widgets:**
```dart
Text('my_key'.tr())
Text('greeting'.tr(args: ['Ahmed']))  // with arguments
Text('items_count'.plural(count))    // plural forms
```

**Adding a new string:**
1. Add the key/value to both `ar.json` and `en.json`
2. Use `'your_key'.tr()` in the widget

**Adding a new language:**
1. Create `assets/translations/{locale}.json` with all keys
2. Add `Locale('xx')` to the `supportedLocales` list in `main.dart`

## Navigation

Package: `go_router`

**Router config:** `lib/core/router/app_router.dart`
- `appRouter` — the `GoRouter` instance used by `MaterialApp.router`
- `AppRoutes` — `const` string identifiers for every named route

**Adding a new screen:**
1. Create the widget under `lib/features/<name>/presentation/<name>_page.dart`
2. Add a constant to `AppRoutes`
3. Register a `GoRoute` in `app_router.dart`

```dart
// AppRoutes
static const profile = 'profile';

// app_router.dart routes list
GoRoute(
  path: '/profile',
  name: AppRoutes.profile,
  builder: (context, state) => const ProfilePage(),
),
```

**Navigating:**
```dart
context.goNamed(AppRoutes.profile);        // replace current
context.pushNamed(AppRoutes.profile);      // push onto stack
context.go('/profile');                    // by path
```

## Networking

Package: `dio`

**Config:** `lib/core/network/`
- `dio_client.dart` — `dioClient`, the single shared `Dio` instance. Base URL,
  timeouts, default headers, and a debug-only `LogInterceptor` are configured here.
- `api_config.dart` — `ApiConfig`: base URL and timeout constants. Change the
  base URL / environment values here, not inline in repositories.

**Rules:**
- Repositories use the shared `dioClient` — never construct their own `Dio`.
- Remote repos live in the repository layer (`features/<name>/data/`) and depend
  on `dioClient`. Don't call Dio directly from UI or BLoC.
- Add cross-cutting concerns (auth tokens, retries, error mapping) as Dio
  interceptors in `dio_client.dart`, not per-call.

```dart
import 'package:mh_salun/core/network/dio_client.dart';

final response = await dioClient.get('/users/$id');
final user = User.fromJson(response.data as Map<String, dynamic>);
```

## JSON Serialization

Packages: `json_annotation` (runtime) + `json_serializable` + `build_runner` (dev, codegen)

Models are plain Dart classes annotated with `@JsonSerializable`. Generated
`*.g.dart` files hold the `fromJson` / `toJson` implementations and are excluded
from analysis in `analysis_options.yaml`.

**Adding a model:**
1. Create the class with `@JsonSerializable()`, a `part '<file>.g.dart';` directive,
   and `fromJson` / `toJson` wired to the generated `_$...` functions.
2. Run codegen (see below).
3. Use `@JsonKey(name: 'api_field')` to map snake_case API fields to Dart names.

```dart
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  const User({required this.id, required this.name});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  final int id;

  @JsonKey(name: 'display_name')
  final String name;

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
```

**Code generation:**
```bash
dart run build_runner build          # one-off generation
dart run build_runner watch          # regenerate on save during development
```
Run after adding or editing any `@JsonSerializable` class. Commit the generated
`*.g.dart` files alongside their source.

## Architecture Notes

**Important Linting:**
- The project uses `flutter_lints` (package:flutter_lints/flutter.yaml)
- Customize rules in `analysis_options.yaml` by uncommenting/modifying the `rules:` section
- Common customizations: `avoid_print`, `prefer_single_quotes`, etc.

## Hot Reload and Development Workflow

Flutter's hot reload allows fast iteration during development:
1. Make changes to Dart code
2. Save the file (or press `r` in the terminal running `flutter run`)
3. App rebuilds and re-renders instantly without losing state (unless you hot restart)
4. Hot restart (`R` in terminal) resets app state and runs `main()` again

This is the primary development loop—use it to test UI changes, business logic, and widget behavior rapidly.
