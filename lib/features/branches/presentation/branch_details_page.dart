import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';
import 'package:mh_salun/features/branches/model/branch.dart';
import 'package:mh_salun/features/branches/presentation/widgets/branch_details_header.dart';
import 'package:mh_salun/features/branches/presentation/widgets/branch_directions_button.dart';
import 'package:mh_salun/features/branches/presentation/widgets/branch_info_row.dart';
import 'package:mh_salun/features/branches/presentation/widgets/branch_section_card.dart';
import 'package:mh_salun/features/branches/presentation/widgets/branch_special_note.dart';
import 'package:mh_salun/features/branches/presentation/widgets/branch_working_hours_row.dart';

const _weekOrder = [
  'MONDAY',
  'TUESDAY',
  'WEDNESDAY',
  'THURSDAY',
  'FRIDAY',
  'SATURDAY',
  'SUNDAY',
];

class BranchDetailsPage extends StatelessWidget {
  const BranchDetailsPage({super.key, required this.branch});

  final Branch branch;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: BackButton(
          color: AppColors.primary,
          onPressed: () => context.pop(),
        ),
        title: Text(branch.name, style: AppTextStyles.titleMedium),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg)
              .copyWith(bottom: AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacing.md),
              BranchDetailsHeader(branch: branch),
              const SizedBox(height: AppSpacing.lg),
              if (branch.specialNote != null) ...[
                BranchSpecialNote(text: branch.specialNote!),
                const SizedBox(height: AppSpacing.lg),
              ],
              BranchSectionCard(
                titleKey: 'branch_details_contact_title',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BranchInfoRow(
                      icon: Icons.location_on_outlined,
                      label: branch.location.address,
                    ),
                    if (branch.phoneNumber?.isNotEmpty ?? false) ...[
                      const SizedBox(height: AppSpacing.sm),
                      BranchInfoRow(
                        icon: Icons.call_outlined,
                        label: branch.phoneNumber!,
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              BranchSectionCard(
                titleKey: 'branch_details_hours_title',
                child: Column(
                  children: [
                    for (final day in _weekOrder)
                      BranchWorkingHoursRow(
                        day: day,
                        hours: branch.workingHours[day],
                      ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              BranchDirectionsButton(branch: branch),
            ],
          ),
        ),
      ),
    );
  }
}
