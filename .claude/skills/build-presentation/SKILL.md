---
name: build-presentation
description: Build the presentation/UI layer of a feature in the mh_salun Flutter app — the first phase of a feature. Use when asked to build a screen/page/UI for a feature (e.g. "build the login screen"), or to lay out an interface before any data wiring. Orchestrates the add-screen, add-route, and add-localized-string skills.
---

# Build presentation (phase 1 of a feature)

This is the **first** phase of building a feature: get the screen rendering with
real text and navigation, before any data/BLoC work. It composes smaller skills —
invoke each via the Skill tool.

## Steps
1. **Create the page/widget** — invoke the **add-screen** skill.
   Place it at `lib/features/<feature>/presentation/<feature>_page.dart`. Use only
   fixed design tokens (`AppSpacing`, `AppFontSize`, `AppTextStyles`) and flex
   widgets for layout — never hardcoded sizes or screen-scaling.
2. **Localize every string** — invoke the **add-localized-string** skill for each
   user-facing text (keys in both `ar.json` and `en.json`, used via `.tr()`).
3. **Wire navigation** — invoke the **add-route** skill to add the `AppRoutes`
   constant and `GoRoute`, so the screen is reachable.

## Keep state local for now
Use plain widgets / `setState` at this phase. Do **not** add a BLoC yet — that
belongs to the integration phase, and only if the BLoC decision rule calls for it.

## Done when
- The screen renders with localized text and adapts to width via flex widgets.
- It is reachable through a named route.
- No data calls yet — wiring to an endpoint is the **build-data-layer** and
  **integrate-feature** phases.
