import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';

import '../../../core/data/auth_exception.dart';
import '../data/register_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

@injectable
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc(this._repo) : super(RegisterInitial()) {
    on<RegisterSubmitted>(_onSubmitted);
  }

  final RegisterRepository _repo;

  Future<void> _onSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());
    try {
      await _repo.register(
        email: event.email,
        password: event.password,
        firstName: event.firstName,
        lastName: event.lastName,
        dateOfBirth: event.dateOfBirth,
      );
      emit(RegisterSuccess());
    } on AuthException catch (e) {
      emit(RegisterFailure(e.message));
    } catch (_) {
      emit(RegisterFailure('register_generic_error'.tr()));
    }
  }
}
