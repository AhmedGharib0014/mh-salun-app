import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../data/app_version_repository.dart';
import '../model/app_update_type.dart';

part 'app_version_event.dart';
part 'app_version_state.dart';

@injectable
class AppVersionBloc extends Bloc<AppVersionEvent, AppVersionState> {
  AppVersionBloc(this._repo) : super(AppVersionInitial()) {
    on<AppVersionCheckRequested>(_onCheckRequested);
  }

  final AppVersionRepository _repo;

  Future<void> _onCheckRequested(
    AppVersionCheckRequested event,
    Emitter<AppVersionState> emit,
  ) async {
    emit(AppVersionChecking());
    try {
      final info = await PackageInfo.fromPlatform();
      print(info.version);
      final result = await _repo.checkVersion(version: info.version);
      switch (result.updateType) {
        case AppUpdateType.none:
          emit(AppVersionUpToDate());
        case AppUpdateType.soft:
          emit(
            AppVersionSoftUpdate(
              storeUrl: result.storeUrl,
              latestVersion: result.latestVersion,
            ),
          );
        case AppUpdateType.hard:
          emit(
            AppVersionHardUpdate(
              storeUrl: result.storeUrl,
              latestVersion: result.latestVersion,
            ),
          );
      }
    } catch (_) {
      // Fail open: never block start-up because the check couldn't complete.
      emit(AppVersionUpToDate());
    }
  }
}
