import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';
import 'package:mh_salun/features/branches/model/branch.dart';
import 'package:mh_salun/features/branches/presentation/widgets/branch_initial_avatar.dart';
import 'package:mh_salun/features/branches/presentation/widgets/branch_details_hint.dart';
import 'package:mh_salun/features/branches/presentation/widgets/branch_location_row.dart';

/// Small, glanceable branch summary. Full details (contact, working hours,
/// special note) live behind [onTap] on the branch details page.
class BranchCard extends StatelessWidget {
  const BranchCard({super.key, required this.branch, required this.onTap});

  final Branch branch;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.18)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            BranchInitialAvatar(initial: branch.initial),
            const SizedBox(height: AppSpacing.md),
            Text(
              branch.name,
              textAlign: TextAlign.center,
              style: AppTextStyles.titleMedium.copyWith(
                fontWeight: FontWeight.w700,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppSpacing.xs),
            BranchLocationRow(address: branch.location.address),
            const Spacer(),
            const BranchDetailsHint(),
          ],
        ),
      ),
    );
  }
}
