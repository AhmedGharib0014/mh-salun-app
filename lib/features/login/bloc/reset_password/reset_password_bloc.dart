import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/data/auth_exception.dart';
import '../../data/forgot_password_repository.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

@injectable
class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc(this._repo) : super(ResetPasswordInitial()) {
    on<ResetPasswordSubmitted>(_onSubmitted);
  }

  final ForgotPasswordRepository _repo;

  Future<void> _onSubmitted(
    ResetPasswordSubmitted event,
    Emitter<ResetPasswordState> emit,
  ) async {
    emit(ResetPasswordLoading());
    try {
      await _repo.requestResetLink(event.email);
      emit(ResetPasswordSuccess());
    } on AuthException catch (e) {
      emit(ResetPasswordFailure(e.message));
    } catch (_) {
      emit(ResetPasswordFailure('login_generic_error'.tr()));
    }
  }
}
