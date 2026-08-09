part of 'profile_bloc.dart';

sealed class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  ProfileLoaded(this.profile);

  final Profile profile;
}

class ProfileFailure extends ProfileState {}
