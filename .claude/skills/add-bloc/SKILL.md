---
name: add-bloc
description: Add event-driven state management (BLoC) to a feature in the mh_salun Flutter app. Use when state must survive navigation, is shared across multiple widgets, or has complex transitions (e.g. loading/success/error for an async action). Covers the bloc/flutter_bloc pattern, events/states, and resolving the BLoC via getIt. First check the BLoC decision rule.
---

# Add a BLoC

Packages: `bloc` + `flutter_bloc`. State management is event-driven.

## First: do you even need a BLoC? (decision rule)
Add a BLoC **only** when at least one is true:
- state survives navigation, **or**
- state is shared across multiple widgets, **or**
- there are complex transitions / state manipulation (e.g. loading → success/error).

Otherwise **skip the BLoC**: use a plain widget with `setState`, and call the repo
directly from the UI.

## Structure
`lib/features/<feature>/bloc/` — a feature-level folder, a sibling of `presentation/`,
`model/`, and `data/` (not nested under `presentation/`). It exists only when the
feature uses a BLoC; omit it entirely otherwise.
- `<feature>_event.dart` — events (user intents)
- `<feature>_state.dart` — states (incl. initial / loading / success / failure)
- `<feature>_bloc.dart` — maps events to states; depends on the repo

```dart
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mh_salun/features/auth/data/auth_repository.dart';

sealed class LoginEvent {}
class LoginSubmitted extends LoginEvent {
  LoginSubmitted(this.email, this.password);
  final String email;
  final String password;
}

sealed class LoginState {}
class LoginInitial extends LoginState {}
class LoginLoading extends LoginState {}
class LoginSuccess extends LoginState {}
class LoginFailure extends LoginState {
  LoginFailure(this.message);
  final String message;
}

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._repo) : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());
      try {
        await _repo.login(event.email, event.password);
        emit(LoginSuccess());
      } catch (e) {
        emit(LoginFailure(e.toString()));
      }
    });
  }

  final AuthRepository _repo;
}
```

## Wire into the UI
- Annotate the BLoC `@injectable` and resolve via `getIt<LoginBloc>()` (invoke the
  **add-di-dependency** skill; run `build_runner`).
- Provide it with `BlocProvider(create: (_) => getIt<LoginBloc>())` and react with
  `BlocBuilder` / `BlocListener`. The full UI↔BLoC↔repo wiring (loading spinner,
  error message, navigate on success) is handled by the **integrate-feature** skill.
