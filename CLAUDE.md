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
- BLoC vs. direct repo call is a decision rule, not an always-on invariant → `add-bloc`
- Repos are split by domain — no god repo objects


### Packages
- State management: `bloc` + `flutter_bloc`
- Navigation: `go_router`
- Networking: `dio`
- JSON: `json_annotation` + `json_serializable` (codegen via `build_runner`)
- Local storage: `shared_preferences`
- Dependency injection: `get_it` + `injectable` (codegen via `build_runner`)

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

## Skills — recipes loaded on demand

Per-package, step-by-step **recipes** live in `.claude/skills/`, loaded only when
relevant instead of always sitting in this file. This file keeps the always-true
**rules**; the skills carry the how-to and code snippets. Invoke a skill via the
Skill tool when its task comes up.

**Feature work composes three phase skills** (matching how a feature is built —
e.g. a login flow):
1. `build-presentation` — build the screen / UI
2. `build-data-layer` — build the client/repository for an endpoint
3. `integrate-feature` — wire UI ↔ data (capture input, loading, request, navigate-or-error)

Each phase orchestrates smaller single-concern skills:

| Skill | Use it when |
|---|---|
| `build-presentation` | building a screen / UI for a feature |
| `build-data-layer` | building a client/repo for an endpoint |
| `integrate-feature` | wiring a screen to an endpoint |
| `add-screen` | creating a page/widget |
| `presentation-rules` | building, updating, or adding sections to any screen |
| `add-route` | registering a screen in go_router |
| `add-localized-string` | adding/using translated text |
| `add-json-model` | creating a JSON-serializable model |
| `add-repo` | creating a Dio repository |
| `add-local-storage` | caching a primitive (token/id/flag) |
| `add-di-dependency` | registering a class/type with `getIt` |
| `add-bloc` | adding event-driven shared state |

## Conventions & where things live (invariants)

These rules always hold. For the *how-to*, invoke the linked skill.

- **Localization** (`easy_localization`) — no hardcoded user-facing strings; every
  string is a key in **both** `assets/translations/ar.json` and `en.json`, used via
  `.tr()`. `ar` is default & fallback. → `add-localized-string`
- **Navigation** (`go_router`) — router in `lib/core/router/app_router.dart`;
  navigate by **named** route (`AppRoutes.x`), never raw paths in app code.
  → `add-route`
- **Networking** (`dio`) — repos **never** construct their own `Dio`; they receive
  the shared instance by constructor injection, and Dio is never called from UI or
  BLoC. Base URL/timeouts in `lib/core/network/api_config.dart`; cross-cutting
  concerns as interceptors in `lib/core/network/dio_client.dart`. → `add-repo`
- **DI** (`get_it` + `injectable`) — annotate your own classes; register third-party
  types in `RegisterModule`. `lib/core/di/injection.config.dart` is generated,
  committed, never hand-edited. Run `build_runner` after changes. → `add-di-dependency`
- **Local storage** (`shared_preferences`) — small, non-sensitive key/value only;
  always through `LocalStorage.prefs`, never `SharedPreferences.getInstance()`
  directly; reads/writes live in the repo's local side. → `add-local-storage`
- **JSON** (`json_serializable`) — models are `@JsonSerializable` plain classes with
  a `part '*.g.dart';`; run `build_runner` and commit the generated file.
  → `add-json-model`
- **State management** (`bloc` + `flutter_bloc`) — add a BLoC only when its
  decision rule calls for it; otherwise use `setState` and call the repo directly.
  → `add-bloc`

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
