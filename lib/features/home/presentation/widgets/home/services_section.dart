import 'package:flutter/material.dart';
import 'package:mh_salun/core/model/service.dart';
import 'package:mh_salun/core/presentation/widgets/service_card.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/features/home/presentation/widgets/home/section_header.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({
    super.key,
    required this.services,
    required this.onSeeAllTap,
  });

  final List<Service> services;
  final VoidCallback onSeeAllTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(
          titleKey: 'home_services_title',
          actionKey: 'home_all',
          onActionTap: onSeeAllTap,
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          itemCount: services.length.clamp(0, 4),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: AppSpacing.md,
            crossAxisSpacing: AppSpacing.md,
            childAspectRatio: 0.78,
          ),
          itemBuilder: (context, index) =>
              ServiceCard(service: services[index]),
        ),
      ],
    );
  }
}
