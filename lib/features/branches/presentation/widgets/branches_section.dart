import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mh_salun/core/presentation/widgets/section_header.dart';
import 'package:mh_salun/core/presentation/widgets/section_loading.dart';
import 'package:mh_salun/core/router/app_router.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/features/branches/bloc/branches_bloc.dart';
import 'package:mh_salun/features/branches/presentation/widgets/branch_card.dart';

/// Section that displays the organization's branches. Consumes the app-wide
/// `BranchesBloc` provided above `MaterialApp`, so it neither owns nor closes
/// it nor triggers the fetch itself — that's centralized in `HomeShellPage`
/// off the organization bloc.
class BranchesSection extends StatelessWidget {
  const BranchesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BranchesBloc, BranchesState>(
      builder: (context, state) {
        if (state is! BranchesLoaded) {
          return const SectionLoading(height: 150);
        }
        final branches = state.branches;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SectionHeader(titleKey: 'home_branches_title'),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: AppSpacing.md,
                crossAxisSpacing: AppSpacing.md,
                mainAxisExtent: 150,
              ),
              itemCount: branches.length,
              itemBuilder: (context, index) {
                final branch = branches[index];
                return BranchCard(
                  branch: branch,
                  onTap: () =>
                      context.pushNamed(AppRoutes.branchDetails, extra: branch),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
