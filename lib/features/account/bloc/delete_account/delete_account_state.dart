part of 'delete_account_bloc.dart';

sealed class DeleteAccountState {}

class DeleteAccountInitial extends DeleteAccountState {}

class DeleteAccountLoading extends DeleteAccountState {}

class DeleteAccountSuccess extends DeleteAccountState {}

class DeleteAccountFailure extends DeleteAccountState {
  DeleteAccountFailure(this.message);

  final String message;
}
