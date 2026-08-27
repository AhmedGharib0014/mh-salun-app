part of 'branches_bloc.dart';

sealed class BranchesState {}

class BranchesInitial extends BranchesState {}

class BranchesLoading extends BranchesState {}

class BranchesLoaded extends BranchesState {
  BranchesLoaded(this.branches);

  final List<Branch> branches;
}

class BranchesFailure extends BranchesState {
  BranchesFailure(this.messageKey);

  final String messageKey;
}
