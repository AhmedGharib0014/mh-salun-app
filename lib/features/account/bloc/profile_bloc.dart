import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../data/profile_repository.dart';
import '../model/profile.dart';

part 'profile_event.dart';
part 'profile_state.dart';

/// Shared app-wide bloc: the profile is loaded once per session and reused
/// across every screen that needs it.
@lazySingleton
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this._repo) : super(ProfileInitial()) {
    on<ProfileRequested>(_onRequested);
    on<ProfileCleared>(_onCleared);
  }

  final ProfileRepository _repo;

  Future<void> _onRequested(
    ProfileRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    try {
      final profile = await _repo.getMyProfile();
      emit(ProfileLoaded(profile));
    } catch (_) {
      emit(ProfileFailure());
    }
  }

  Future<void> _onCleared(
    ProfileCleared event,
    Emitter<ProfileState> emit,
  ) async {
    await _repo.clearProfile();
    emit(ProfileInitial());
  }
}
