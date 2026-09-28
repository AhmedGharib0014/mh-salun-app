import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mh_salun/core/di/injection.dart';
import 'package:mh_salun/features/app_version/bloc/app_version_bloc.dart';
import 'package:mh_salun/features/app_version/presentation/widgets/update_dialogs.dart';
import 'package:mh_salun/features/auth/bloc/auth_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  /// Asks the [AuthBloc] whether a session exists. The navigation that follows
  /// is handled by the global auth listener in `main.dart`.
  void _checkSession() {
    if (!mounted) return;
    context.read<AuthBloc>().add(AuthCheckRequested());
  }

  /// Reacts to the version check. A blocking (hard) update keeps the user on
  /// the splash screen behind a non-dismissible dialog; anything else lets
  /// start-up continue once handled.
  void _onVersionState(BuildContext context, AppVersionState state) {
    switch (state) {
      case AppVersionInitial():
      case AppVersionChecking():
        break;
      case AppVersionUpToDate():
        _checkSession();
      case AppVersionSoftUpdate(:final storeUrl, :final latestVersion):
        showSoftUpdateDialog(
          context,
          storeUrl: storeUrl,
          latestVersion: latestVersion,
        ).then((_) => _checkSession());
      case AppVersionHardUpdate(:final storeUrl, :final latestVersion):
        showHardUpdateDialog(
          context,
          storeUrl: storeUrl,
          latestVersion: latestVersion,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Fire the check as soon as the splash screen mounts and wait for the
      // response before continuing start-up.
      create: (_) => getIt<AppVersionBloc>()..add(AppVersionCheckRequested()),
      child: BlocListener<AppVersionBloc, AppVersionState>(
        listener: _onVersionState,
        child: Scaffold(
          backgroundColor: const Color(0xFF202020), // matches image bg
          body: SizedBox.expand(
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.contain, // fills the whole screen, no distortion
            ),
          ),
        ),
      ),
    );
  }
}
