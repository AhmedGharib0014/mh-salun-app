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

**Feature-first.** The first level under `lib/` is exactly two directories: `features/` and `core/`.

```
lib/
├── core/                     # cross-feature code (router, theme, di, shared widgets/utils)
└── features/
    └── <feature_name>/       # one directory per feature
        ├── presentation/     # screens + a widgets/ folder for widgets used only by this feature
        ├── bloc/             # bloc/event/state files for this feature (optional — omit if not using bloc)
        ├── model/            # models carrying data between presentation and data, both directions
        └── data/             # repositories and clients (API/network, local storage)
```

### Rules
- Under `lib/` there are only `features/` and `core/` — nothing else.
- Each feature owns these layers: `presentation/`, `model/`, `data/`, and an optional `bloc/`.
- `presentation/` holds the feature's screens plus a `widgets/` subfolder for widgets used only by that feature.
- `bloc/` holds the feature's bloc/event/state files. It is optional — only present when the feature uses bloc; omit it otherwise (→ `add-bloc`).
- `model/` holds the data models passed between `presentation/` and `data/` (request/response/view models) — used in both directions.
- `data/` holds repositories and clients (network + local storage).
- Code shared across features lives in `core/`, not inside any feature.
- If something is shared between features, move it to `core/` under the folder that corresponds to its layer (e.g. shared models → `core/model/`, shared clients/repos → `core/data/`, shared widgets → `core/presentation/`). Do not let one feature reach into another.
