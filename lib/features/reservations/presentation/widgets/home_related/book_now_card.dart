import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/home_related/book_now_content.dart';

class BookNowCard extends StatelessWidget {
  const BookNowCard({super.key, required this.onStartBooking});

  final VoidCallback onStartBooking;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        0,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.primaryLight, AppColors.primary],
          ),
          borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.25),
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
          child: Stack(
            children: [
              // Defined luminous disc in the top-left corner (soft edge).
              Positioned(
                top: -30,
                left: 8,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.primaryLight.withValues(alpha: 0.65),
                        AppColors.primaryLight.withValues(alpha: 0.65),
                        AppColors.primaryLight.withValues(alpha: 0.0),
                      ],
                      stops: const [0.0, 0.62, 1.0],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: BookNowContent(onStartBooking: onStartBooking),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
