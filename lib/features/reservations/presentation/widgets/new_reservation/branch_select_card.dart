import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';
import 'package:mh_salun/features/branches/model/branch.dart';
import 'package:mh_salun/features/branches/presentation/widgets/branch_initial_avatar.dart';
import 'package:mh_salun/features/branches/presentation/widgets/branch_location_row.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/selection_mark.dart';

/// Selectable branch row for the "choose a branch" step. A gold ring and a
/// check badge mark the currently selected branch. Laid out full-width (rather
/// than as a grid tile like the barber step) so the address stays readable.
class BranchSelectCard extends StatelessWidget {
  const BranchSelectCard({
    super.key,
    required this.branch,
    required this.selected,
    required this.onTap,
  });

  final Branch branch;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
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
        child: Row(
          children: [
            BranchInitialAvatar(
              initial: branch.initial,
              textStyle: AppTextStyles.titleLarge,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    branch.name,
                    style: AppTextStyles.titleMedium.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  BranchLocationRow(address: branch.location.address),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            SelectionMark(selected: selected),
          ],
        ),
      ),
    );
  }
}
