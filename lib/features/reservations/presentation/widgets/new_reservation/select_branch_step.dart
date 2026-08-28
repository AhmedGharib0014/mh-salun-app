import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mh_salun/core/presentation/widgets/section_loading.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/features/branches/bloc/branches_bloc.dart';
import 'package:mh_salun/features/branches/model/branch.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/booking_step_header.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/branch_select_card.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/step_message.dart';

/// Step 1 of the new-reservation flow: pick the branch the guest will visit.
/// Reads the app-wide `BranchesBloc` (already loaded for the home screen), so
/// it neither owns nor closes it nor triggers the fetch itself.
class SelectBranchStep extends StatelessWidget {
  const SelectBranchStep({
    super.key,
    required this.selectedBranch,
    required this.onBranchSelected,
  });

  final Branch? selectedBranch;
  final ValueChanged<Branch> onBranchSelected;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BranchesBloc, BranchesState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.md,
              ),
              child: BookingStepHeader(
                titleKey: 'new_reservation_branch_title',
                subtitleKey: 'new_reservation_branch_subtitle',
              ),
            ),
            Expanded(
              child: switch (state) {
                BranchesFailure(:final messageKey) => StepMessage(
                  icon: Icons.error_outline_rounded,
                  messageKey: messageKey,
                ),
                BranchesLoaded(:final branches) when branches.isEmpty =>
                  const StepMessage(
                    icon: Icons.store_mall_directory_outlined,
                    messageKey: 'new_reservation_branch_empty',
                  ),
                BranchesLoaded(:final branches) => ListView.separated(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    0,
                    AppSpacing.lg,
                    AppSpacing.lg,
                  ),
                  itemCount: branches.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: AppSpacing.md),
                  itemBuilder: (context, index) {
                    final branch = branches[index];
                    return BranchSelectCard(
                      branch: branch,
                      selected: branch.id == selectedBranch?.id,
                      onTap: () => onBranchSelected(branch),
                    );
                  },
                ),
                BranchesInitial() ||
                BranchesLoading() => const SectionLoading(
                  height: double.infinity,
                ),
              },
            ),
          ],
        );
      },
    );
  }
}
