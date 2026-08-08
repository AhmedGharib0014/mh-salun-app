class AppSpacing {
  AppSpacing._();

  static const xs = 3.5;
  static const sm = 7.0;
  static const md = 14.0;
  static const lg = 22.0;
  static const xl = 29.0;
  static const xxl = 43.0;

  static const iconSm = 18.0;
  static const iconMd = 22.0;
  static const iconLg = 29.0;

  static const radiusSm = 4.0;
  static const radiusMd = 8.0;
  static const radiusLg = 12.0;
  static const radiusXl = 16.0;
  static const radiusFull = 100.0;

  /// Vertical space the curved bottom nav bar (plus its raised circle)
  /// covers over the body, excluding the device's bottom inset. Scrollable
  /// tab content should reserve this much bottom padding so its last item
  /// clears the bar. Must track HomeBottomNav's bar height + overhang.
  static const bottomNavClearance = 106.0;
}
