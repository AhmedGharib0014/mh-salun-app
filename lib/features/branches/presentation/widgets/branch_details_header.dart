import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';
import 'package:mh_salun/features/branches/model/branch.dart';
import 'package:mh_salun/features/branches/presentation/widgets/branch_initial_avatar.dart';

class BranchDetailsHeader extends StatelessWidget {
  const BranchDetailsHeader({super.key, required this.branch});

  final Branch branch;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BranchInitialAvatar(
          initial: branch.initial,
          size: AppSpacing.xxl + AppSpacing.md,
          textStyle: AppTextStyles.titleLarge,
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                branch.name,
                style: AppTextStyles.titleLarge,
              ),
              if (branch.description?.isNotEmpty ?? false) ...[
                const SizedBox(height: AppSpacing.xs),
                Text(
                  branch.description!,
                  style: AppTextStyles.bodySecondary,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
