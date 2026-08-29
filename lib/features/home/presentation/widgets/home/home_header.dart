import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/font_sizes.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';
import 'package:mh_salun/features/home/bloc/organization/organization_bloc.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        0,
      ),
      child: Row(
        children: [
          Container(
            width: AppSpacing.xxl,
            height: AppSpacing.xxl,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
              border: Border.all(color: AppColors.primary, width: 1.2),
            ),
            alignment: Alignment.center,
            child: Text(
              'MH',
              style: GoogleFonts.playfairDisplay(
                fontSize: AppFontSize.title,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<OrganizationBloc, OrganizationState>(
                  builder: (context, state) {
                    if (state is OrganizationLoaded) {
                      return Text(
                        state.organization.name,
                        style: AppTextStyles.titleLarge,
                        overflow: TextOverflow.ellipsis,
                      );
                    }
                    if (state is OrganizationFailure) {
                      return Text(
                        'home_salon_name'.tr(),
                        style: AppTextStyles.titleLarge,
                        overflow: TextOverflow.ellipsis,
                      );
                    }
                    return SizedBox(
                      width: AppSpacing.xxl * 2,
                      height: AppFontSize.title,
                      child: const LinearProgressIndicator(
                        color: AppColors.primary,
                        backgroundColor: AppColors.surface,
                      ),
                    );
                  },
                ),
                Text(
                  'home_salon_tagline'.tr(),
                  style: AppTextStyles.label,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
