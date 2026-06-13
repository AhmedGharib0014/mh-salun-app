import 'package:flutter/material.dart';

abstract final class AppColors {
  // Backgrounds — soft warm charcoal, lifted off pure-black for low eye strain
  static const Color background = Color(0xFF1A1714);
  static const Color surface = Color(0xFF232019);
  static const Color surfaceHigh = Color(0xFF2E2A22);

  // Gold scale — matched to the luminous amber-gold of the logo
  static const Color primary = Color(0xFFE5A526);
  static const Color primaryLight = Color(0xFFF6C95C);
  static const Color primaryDark = Color(0xFFB17C18);

  // AppBar — lifted dark bar (distinct from page background) with gold title/icons
  static const Color appBar = Color(0xFF2A251E);
  static const Color onAppBar = primary;

  // On-colors
  static const Color onPrimary = Color(0xFF160F02);
  static const Color onBackground = Color(0xFFF3EFE7);
  static const Color onSurface = Color(0xFFA59E90);

  // Structural
  static const Color divider = Color(0xFF383229);
  static const Color outline = Color(0xFF443D32);

  // Semantic
  static const Color error = Color(0xFFE5707F);
  static const Color onError = Color(0xFF160F02);
}
