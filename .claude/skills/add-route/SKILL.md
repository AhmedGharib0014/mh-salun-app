---
name: add-route
description: Register a screen in navigation (go_router) for the mh_salun Flutter app. Use when adding a new page to the router, wiring navigation between screens, adding a named route, or when a screen exists but cannot be navigated to yet. Covers AppRoutes constants and GoRoute registration in lib/core/router/app_router.dart.
---

# Add a route

Package: `go_router`. Router config lives in
`lib/core/router/app_router.dart`:
- `appRouter` — the `GoRouter` used by `MaterialApp.router`
- `AppRoutes` — `const` string names for every route

## Register a screen
1. Add a name constant to `AppRoutes`:
   ```dart
   class AppRoutes {
     static const home = 'home';
     static const login = 'login'; // new
   }
   ```
2. Add a `GoRoute` to the `routes` list (import the page at the top):
   ```dart
   GoRoute(
     path: '/login',
     name: AppRoutes.login,
     builder: (context, state) => const LoginPage(),
   ),
   ```

## Navigate
```dart
context.goNamed(AppRoutes.login);     // replace current
context.pushNamed(AppRoutes.login);   // push onto stack
context.go('/login');                 // by path
```

## Notes
- Always navigate by **named route** (`AppRoutes.x`), not raw path strings, in app code.
- The page widget itself is created by the **add-screen** skill; this skill only wires routing.
