import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mh_salun/core/router/app_router.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';
import 'package:mh_salun/features/home/model/services_catalog.dart';
import 'package:mh_salun/features/home/presentation/widgets/home/home_bottom_nav.dart';
import 'package:mh_salun/features/home/presentation/widgets/services/all_services_grid.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  static const int _navIndex = 1;

  void _onNavSelected(int index) {
    if (index == _navIndex) return;
    if (index == 0) context.goNamed(AppRoutes.home);
    // Bookings and account tabs have no screens yet.
  }

  void _onAddTap() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
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
      ),
      bottomNavigationBar: HomeBottomNav(
        selectedIndex: _navIndex,
        onDestinationSelected: _onNavSelected,
        onAddTap: _onAddTap,
      ),
    );
  }
}
