import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/data/auth_exception.dart';
import '../../data/delete_account_repository.dart';

part 'delete_account_event.dart';
part 'delete_account_state.dart';

@injectable
class DeleteAccountBloc extends Bloc<DeleteAccountEvent, DeleteAccountState> {
  DeleteAccountBloc(this._repo) : super(DeleteAccountInitial()) {
    on<DeleteAccountSubmitted>(_onSubmitted);
  }

  final DeleteAccountRepository _repo;

  Future<void> _onSubmitted(
    DeleteAccountSubmitted event,
    Emitter<DeleteAccountState> emit,
  ) async {
    emit(DeleteAccountLoading());
    try {
      await _repo.deleteMyAccount();
      emit(DeleteAccountSuccess());
    } on AuthException catch (e) {
      emit(DeleteAccountFailure(e.message));
    } catch (_) {
      emit(DeleteAccountFailure('delete_account_generic_error'.tr()));
    }
  }
}
