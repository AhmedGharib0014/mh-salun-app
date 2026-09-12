part of 'delete_account_bloc.dart';

sealed class DeleteAccountEvent {}

/// Dispatched when the user confirms permanently deleting their account.
class DeleteAccountSubmitted extends DeleteAccountEvent {}
