import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';
import 'package:mh_salun/features/home/model/services_catalog.dart';
import 'package:mh_salun/features/home/presentation/widgets/services/all_services_grid.dart';

class ServicesTabView extends StatelessWidget {
  const ServicesTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg,
              0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'services_title'.tr(),
                  style: AppTextStyles.headingLarge,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'services_subtitle'.tr(),
                  style: AppTextStyles.bodySecondary,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: AllServicesGrid(services: ServicesCatalog.all()),
          ),
        ],
      ),
    );
  }
}
