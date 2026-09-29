import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/data/api_exception.dart';
import '../../data/resend_verification_repository.dart';

part 'resend_verification_event.dart';
part 'resend_verification_state.dart';

@injectable
class ResendVerificationBloc
    extends Bloc<ResendVerificationEvent, ResendVerificationState> {
  ResendVerificationBloc(this._repo) : super(ResendVerificationInitial()) {
    on<ResendVerificationSubmitted>(_onSubmitted);
  }

  final ResendVerificationRepository _repo;

  Future<void> _onSubmitted(
    ResendVerificationSubmitted event,
    Emitter<ResendVerificationState> emit,
  ) async {
    emit(ResendVerificationLoading());
    try {
      await _repo.resendVerification(event.email);
      emit(ResendVerificationSuccess());
    } on ApiException catch (e) {
      emit(ResendVerificationFailure(e.message));
    } catch (_) {
      emit(ResendVerificationFailure('register_generic_error'.tr()));
    }
  }
}
