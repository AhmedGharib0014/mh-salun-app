import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

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
    } on DioException catch (_) {
      emit(BranchesFailure('network_error'));
    } catch (_) {
      emit(BranchesFailure('branches_generic_error'));
    }
  }
}
