import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/data/api_exception.dart';
import '../../data/profile_repository.dart';
import '../../model/profile.dart';

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
    } on ApiException catch (e) {
      emit(ProfileFailure(e.message));
    } catch (_) {
      emit(ProfileFailure('profile_generic_error'.tr()));
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
