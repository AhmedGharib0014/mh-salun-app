import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';
import 'package:mh_salun/features/home/presentation/widgets/home/home_bottom_nav.dart';

/// Generic "not built yet" content for a bottom-nav tab.
class TabPlaceholderView extends StatelessWidget {
  const TabPlaceholderView({
    super.key,
    required this.icon,
    required this.titleKey,
  });

  final IconData icon;
  final String titleKey;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: HomeBottomNav.scrollClearance +
                MediaQuery.of(context).padding.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: AppSpacing.xxl, color: AppColors.onSurface),
              const SizedBox(height: AppSpacing.md),
              Text(titleKey.tr(), style: AppTextStyles.titleMedium),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'placeholder_coming_soon'.tr(),
                style: AppTextStyles.bodySecondary,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
