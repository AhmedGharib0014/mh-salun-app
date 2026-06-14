---
name: integrate-feature
description: Integrate the presentation and data layers of a feature in the mh_salun Flutter app — the third/final phase. Use when asked to wire a screen to an endpoint (e.g. "wire the login button to the endpoint"), capture user input, show loading, send a request, and navigate-or-show-error on the result. Orchestrates the add-bloc skill plus UI↔repo wiring.
---

# Integrate feature (phase 3 of a feature)

The **final** phase: connect the screen (from **build-presentation**) to the
repository (from **build-data-layer**) so a user action runs the full flow —
capture input → show loading → send request → navigate on success or show an error.

## Decide: BLoC or direct repo call?
Apply the BLoC decision rule (see the **add-bloc** skill). For an async action with
loading/success/error transitions, a BLoC is usually warranted.
- **Needs a BLoC** → invoke the **add-bloc** skill (events, states incl.
  loading/success/failure, depends on the repo), register it via
  **add-di-dependency**, run `build_runner`.
- **Simple, screen-only** → skip the BLoC: call `getIt<Repo>()` directly from the
  widget with local `setState` for the loading flag.

## Wire the UI (BLoC path)
1. Provide the BLoC: `BlocProvider(create: (_) => getIt<XBloc>())`.
2. Capture input from controllers and dispatch an event on the button press
   (e.g. `context.read<XBloc>().add(LoginSubmitted(email, password))`).
3. React with `BlocConsumer`/`BlocListener` + `BlocBuilder`:
   - `loading` → show a spinner / disable the button
   - `success` → navigate (invoke **add-route** target via `context.goNamed(...)`)
   - `failure` → show the error message (localized via **add-localized-string**)

```dart
BlocConsumer<LoginBloc, LoginState>(
  listener: (context, state) {
    if (state is LoginSuccess) context.goNamed(AppRoutes.home);
    if (state is LoginFailure) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(state.message)));
    }
  },
  builder: (context, state) => FilledButton(
    onPressed: state is LoginLoading
        ? null
        : () => context.read<LoginBloc>().add(
              LoginSubmitted(emailCtrl.text, passwordCtrl.text),
            ),
    child: state is LoginLoading
        ? const CircularProgressIndicator()
        : Text('login_button'.tr()),
  ),
);
```

## Done when
- Pressing the action captures input, shows loading, calls the repo,
  then navigates on success or shows a localized error.
- All three layers (UI ↔ BLoC ↔ repo) are connected and the flow works end to end.
