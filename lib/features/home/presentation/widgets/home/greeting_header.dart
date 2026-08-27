import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mh_salun/core/theme/font_sizes.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';
import 'package:mh_salun/features/account/bloc/profile_bloc.dart';

class GreetingHeader extends StatelessWidget {
  const GreetingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'home_greeting_evening'.tr(),
            style: AppTextStyles.bodySecondary,
          ),
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              final name = state is ProfileLoaded
                  ? state.profile.firstName
                  : 'home_customer_name'.tr();
              return Text(
                name,
                style: AppTextStyles.headingLarge.copyWith(
                  fontSize: AppFontSize.display,
                  fontWeight: FontWeight.w600,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
