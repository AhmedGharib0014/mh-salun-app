import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';
import 'package:mh_salun/features/branches/model/branch.dart';
import 'package:mh_salun/features/branches/presentation/widgets/branch_initial_avatar.dart';
import 'package:mh_salun/features/branches/presentation/widgets/branch_location_row.dart';

/// Read-only branch summary shown in the review step: initial avatar, name and
/// address.
class BranchRow extends StatelessWidget {
  const BranchRow({super.key, required this.branch});

  final Branch branch;

  @override
  Widget build(BuildContext context) {
    return Row(
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
      ],
    );
  }
}
