---
name: build-data-layer
description: Build the data layer of a feature in the mh_salun Flutter app — the second phase of a feature. Use when asked to build a client/repository for an API endpoint (e.g. "build a client to call the login endpoint"), parse responses, or add data access. Orchestrates the add-json-model, add-repo, add-di-dependency, and (when caching) add-local-storage skills.
---

# Build data layer (phase 2 of a feature)

The **second** phase: build the client/repository that talks to the endpoint,
independent of the UI. It composes smaller skills — invoke each via the Skill tool.

## Steps
1. **Model the payloads** — invoke the **add-json-model** skill for the request
   and/or response shapes. Place models in `lib/features/<feature>/data/`. Run
   `build_runner` after.
2. **Create the repository** — invoke the **add-repo** skill. The repo lives in
   `lib/features/<feature>/data/`, is annotated (`@lazySingleton` typically), and
   receives the shared `Dio` by constructor injection — it never builds its own.
   It calls the endpoint and returns typed models.
3. **Persist primitives if needed** — if the repo caches a token/id/flag, invoke
   the **add-local-storage** skill (local side of the repo, via `LocalStorage`).
4. **Register it** — invoke the **add-di-dependency** skill so the repo resolves
   via `getIt<T>()`; run `build_runner` to regenerate `injection.config.dart`.

## Done when
- Models parse the endpoint's JSON; `*.g.dart` generated and committed.
- The repository calls the endpoint with injected `Dio` and returns typed data.
- The repo is registered and resolvable via `getIt`.
- No UI/BLoC references yet — connecting them is the **integrate-feature** phase.
