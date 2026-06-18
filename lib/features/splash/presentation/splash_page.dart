import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mh_salun/core/router/app_router.dart';
import 'package:mh_salun/core/theme/app_colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), _navigateToLogin);
  }

  void _navigateToLogin() {
    if (mounted) context.goNamed(AppRoutes.login);
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
