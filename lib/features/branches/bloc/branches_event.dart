part of 'branches_bloc.dart';

sealed class BranchesEvent {}

/// Dispatched when the home screen needs branches loaded for an organization.
class BranchesRequested extends BranchesEvent {
  BranchesRequested(this.orgId);

  final String orgId;
}

/// Dispatched on logout, and on a new successful login, to drop the previous
/// session's cached branches.
class BranchesCleared extends BranchesEvent {}
