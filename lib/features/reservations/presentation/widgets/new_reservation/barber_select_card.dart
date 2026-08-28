import 'package:flutter/material.dart';
import 'package:mh_salun/core/presentation/widgets/avatar_circle.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';
import 'package:mh_salun/features/employees/model/employee.dart';

/// Selectable barber tile for the "choose your barber" step. A gold ring and
/// a check badge mark the currently selected barber.
class BarberSelectCard extends StatelessWidget {
  const BarberSelectCard({
    super.key,
    required this.employee,
    required this.selected,
    required this.onTap,
  });

  final Employee employee;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final user = employee.user;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary.withValues(alpha: 0.10)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
          border: Border.all(
            color: selected
                ? AppColors.primary
                : AppColors.primary.withValues(alpha: 0.18),
            width: selected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                AvatarCircle(
                  initial: user.firstName.characters.firstOrNull ?? '',
                  size: 72,
                  imageUrl: user.avatarUrl,
                  textStyle: AppTextStyles.headingLarge,
                  border: Border.all(
                    color: selected ? AppColors.primary : AppColors.outline,
                    width: 2,
                  ),
                ),
                if (selected)
                  Positioned(
                    right: -2,
                    bottom: -2,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.background,
                      ),
                      child: const CircleAvatar(
                        radius: 11,
                        backgroundColor: AppColors.primary,
                        child: Icon(
                          Icons.check,
                          size: 14,
                          color: AppColors.onPrimary,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              '${user.firstName} ${user.lastName}',
              style: AppTextStyles.titleMedium.copyWith(
                fontWeight: FontWeight.w700,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppSpacing.xs),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.star,
                  size: AppSpacing.iconSm - 4,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 2),
                Text(
                  employee.ratingAvg.toStringAsFixed(1),
                  style: AppTextStyles.bodyGold.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
