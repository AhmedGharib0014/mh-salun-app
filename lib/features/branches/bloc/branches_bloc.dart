import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';

import '../../../core/data/api_exception.dart';
import '../data/branch_repository.dart';
import '../model/branch.dart';

part 'branches_event.dart';
part 'branches_state.dart';

/// Shared app-wide bloc: branches are loaded once per organization and
/// reused across every screen that needs them (home, ...).
@lazySingleton
class BranchesBloc extends Bloc<BranchesEvent, BranchesState> {
  BranchesBloc(this._repo) : super(BranchesInitial()) {
    on<BranchesRequested>(_onRequested);
    on<BranchesCleared>(_onCleared);
  }

  final BranchRepository _repo;

  Future<void> _onRequested(
    BranchesRequested event,
    Emitter<BranchesState> emit,
  ) async {
    emit(BranchesLoading());
    try {
      final branches = await _repo.getBranches(orgId: event.orgId);
      emit(BranchesLoaded(branches));
    } on ApiException catch (e) {
      emit(BranchesFailure(e.message));
    } catch (_) {
      emit(BranchesFailure('branches_generic_error'.tr()));
    }
  }

  void _onCleared(BranchesCleared event, Emitter<BranchesState> emit) {
    emit(BranchesInitial());
  }
}
