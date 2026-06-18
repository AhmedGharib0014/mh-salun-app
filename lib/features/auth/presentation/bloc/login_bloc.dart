import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';

import '../../data/auth_exception.dart';
import '../../data/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._repo) : super(LoginInitial()) {
    on<LoginSubmitted>(_onSubmitted);
  }

  final AuthRepository _repo;

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      await _repo.login(event.email, event.password);
      emit(LoginSuccess());
    } on AuthException catch (e) {
      emit(LoginFailure(e.message));
    } catch (_) {
      emit(LoginFailure('login_generic_error'.tr()));
    }
  }
}
