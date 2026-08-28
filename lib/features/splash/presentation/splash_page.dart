import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mh_salun/features/auth/bloc/auth_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), _checkSession);
  }

  /// Asks the [AuthBloc] whether a session exists. The navigation that follows
  /// is handled by the global auth listener in `main.dart`.
  void _checkSession() {
    if (!mounted) return;
    context.read<AuthBloc>().add(AuthCheckRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF202020), // matches image bg
      body: SizedBox.expand(
        child: Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.contain, // fills the whole screen, no distortion
        ),
      ),
    );
  }
}
