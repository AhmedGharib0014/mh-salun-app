import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/features/account/model/account_profile.dart';
import 'package:mh_salun/features/account/presentation/widgets/account/account_header.dart';
import 'package:mh_salun/features/account/presentation/widgets/account/account_info_section.dart';

class AccountTabView extends StatelessWidget {
  const AccountTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = AccountProfile.mock();

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
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
      ),
    );
  }
}
