import 'package:flutter/material.dart';
import 'package:mh_salun/core/model/service.dart';
import 'package:mh_salun/core/presentation/widgets/service_card.dart';
import 'package:mh_salun/core/theme/spacing.dart';

/// Scrollable two-column grid of every service, padded so the last row
/// clears the curved bottom nav bar.
class AllServicesGrid extends StatelessWidget {
  const AllServicesGrid({super.key, required this.services});

  final List<Service> services;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.lg,
        0,
        AppSpacing.lg,
        AppSpacing.bottomNavClearance + MediaQuery.of(context).padding.bottom,
      ),
      itemCount: services.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: AppSpacing.md,
        crossAxisSpacing: AppSpacing.md,
        childAspectRatio: 0.78,
      ),
      itemBuilder: (context, index) => ServiceCard(service: services[index]),
    );
  }
}
