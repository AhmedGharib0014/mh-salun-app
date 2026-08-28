import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/data/token_storage.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@lazySingleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._tokenStorage) : super(AuthInitial()) {
    on<AuthCheckRequested>(_onCheckRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  final TokenStorage _tokenStorage;

  void _onCheckRequested(AuthCheckRequested event, Emitter<AuthState> emit) {
    emit(_tokenStorage.isLoggedIn ? Authenticated() : Unauthenticated());
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _tokenStorage.clearTokens();
    emit(Unauthenticated());
  }
}
