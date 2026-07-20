import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';

/// Curved bottom navigation bar: the bar carves a fixed notch under the
/// center "add" button, where a floating gold circle sits. The four
/// destinations around it indicate selection by color only.
class HomeBottomNav extends StatelessWidget {
  const HomeBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.onAddTap,
  });

  /// Vertical space the bar (plus the raised circle) covers over the body,
  /// excluding the device's bottom inset — use it as scroll clearance.
  static const double scrollClearance = _overhang + _barHeight + AppSpacing.sm;

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final VoidCallback onAddTap;

  static const List<({IconData icon, String labelKey})> _destinations = [
    (icon: Icons.home_outlined, labelKey: 'home_nav_home'),
    (icon: Icons.list_alt_outlined, labelKey: 'home_nav_services'),
    (icon: Icons.calendar_today_outlined, labelKey: 'home_nav_bookings'),
    (icon: Icons.person_outline, labelKey: 'home_nav_account'),
  ];

  static const double _barHeight = 64;
  static const double _circleSize = 56;
  // How far the floating circle pokes above the bar's top edge; its bottom
  // rests inside the notch, just above the notch's deepest point.
  static const double _overhang = 34;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return SizedBox(
      height: _overhang + _barHeight + bottomInset,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final notchCenter = constraints.maxWidth / 2;
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: 0,
                right: 0,
                top: _overhang,
                bottom: 0,
                child: CustomPaint(
                  painter: _CurvedBarPainter(notchCenter: notchCenter),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: _overhang,
                height: _barHeight,
                child: Row(
                  children: [
                    Expanded(child: _buildDestination(0)),
                    Expanded(child: _buildDestination(1)),
                    // Empty slot under the floating add button.
                    const Spacer(),
                    Expanded(child: _buildDestination(2)),
                    Expanded(child: _buildDestination(3)),
                  ],
                ),
              ),
              Positioned(
                left: notchCenter - _circleSize / 2,
                top: 0,
                child: _buildAddButton(),
              ),
            ],
          );
        },
      ),
    );
  }

  /// The raised gold circle sitting in the notch — a standalone add action.
  Widget _buildAddButton() {
    return GestureDetector(
      onTap: onAddTap,
      child: Container(
        width: _circleSize,
        height: _circleSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.primaryLight, AppColors.primary],
          ),
          border: Border.all(color: AppColors.background, width: 4),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.45),
              blurRadius: 18,
              spreadRadius: 1,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: const Icon(
          Icons.add,
          color: AppColors.onPrimary,
          size: AppSpacing.iconMd,
        ),
      ),
    );
  }

  Widget _buildDestination(int index) {
    final destination = _destinations[index];
    final color =
        index == selectedIndex ? AppColors.primary : AppColors.onSurface;
    return GestureDetector(
      onTap: () => onDestinationSelected(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(destination.icon, color: color, size: AppSpacing.iconMd),
            const SizedBox(height: AppSpacing.xs),
            Text(
              destination.labelKey.tr(),
              style: AppTextStyles.label.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}

/// Paints the bar body with a smooth notch dipping below [notchCenter].
class _CurvedBarPainter extends CustomPainter {
  const _CurvedBarPainter({required this.notchCenter});

  final double notchCenter;

  static const double _notchDepth = 30;
  static const double _notchHalfSpan = 66;

  Path _topContour(Size size) {
    final cx = notchCenter;
    return Path()
      ..moveTo(0, 0)
      ..lineTo(cx - _notchHalfSpan, 0)
      ..cubicTo(
        cx - _notchHalfSpan * 0.55, 0,
        cx - _notchHalfSpan * 0.35, _notchDepth,
        cx, _notchDepth,
      )
      ..cubicTo(
        cx + _notchHalfSpan * 0.35, _notchDepth,
        cx + _notchHalfSpan * 0.55, 0,
        cx + _notchHalfSpan, 0,
      )
      ..lineTo(size.width, 0);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final contour = _topContour(size);
    final body = Path.from(contour)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    // Soft ambient shadow rising above the bar edge.
    canvas.drawPath(
      body.shift(const Offset(0, -3)),
      Paint()
        ..color = const Color(0x33000000)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10),
    );

    canvas.drawPath(
      body,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.surfaceHigh, AppColors.surface],
        ).createShader(Offset.zero & size),
    );

    canvas.drawPath(
      contour,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1
        ..color = AppColors.outline,
    );
  }

  @override
  bool shouldRepaint(_CurvedBarPainter oldDelegate) =>
      oldDelegate.notchCenter != notchCenter;
}
