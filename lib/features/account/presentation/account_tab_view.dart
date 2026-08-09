import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/features/account/bloc/profile_bloc.dart';
import 'package:mh_salun/features/account/presentation/widgets/account/account_header.dart';
import 'package:mh_salun/features/account/presentation/widgets/account/account_info_section.dart';

/// Fetch of the underlying `ProfileBloc` data is centralized in
/// `HomeShellPage`, so this view just renders whatever state the shared
/// bloc is currently in.
class AccountTabView extends StatelessWidget {
  const AccountTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoaded) {
            final profile = state.profile;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppSpacing.lg),
                  AccountHeader(profile: profile),
                  const SizedBox(height: AppSpacing.lg),
                  AccountInfoSection(profile: profile),
                  SizedBox(
                    height: AppSpacing.bottomNavClearance +
                        MediaQuery.of(context).padding.bottom,
                  ),
                ],
              ),
            );
          }
          if (state is ProfileFailure) {
            return const Center(
              child: Icon(Icons.error_outline, color: AppColors.primary),
            );
          }
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        },
      ),
    );
  }
}
