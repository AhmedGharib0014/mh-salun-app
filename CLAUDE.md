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
