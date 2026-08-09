import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mh_salun/core/presentation/widgets/section_header.dart';
import 'package:mh_salun/core/presentation/widgets/section_loading.dart';
import 'package:mh_salun/core/presentation/widgets/service_card.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/features/services/bloc/services_bloc.dart';
import 'package:mh_salun/features/services/model/catalog_item_x.dart';

/// Section that displays the organization's services. Consumes the
/// app-wide `ServicesBloc` provided above `MaterialApp`, so it neither owns
/// nor closes it nor triggers the fetch itself — that's centralized in
/// `HomeShellPage` off the organization bloc.
class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key, required this.onSeeAllTap});

  final VoidCallback onSeeAllTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServicesBloc, ServicesState>(
      builder: (context, state) => switch (state) {
        ServicesInitial() || ServicesLoading() =>
          const SectionLoading(height: 220),
        ServicesFailure() => const SizedBox(
            height: 220,
            child: Center(
              child: Icon(Icons.error_outline, color: AppColors.primary),
            ),
          ),
        ServicesLoaded(:final items) => Column(
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
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                ),
                itemCount: items.length.clamp(0, 4),
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: AppSpacing.md,
                  crossAxisSpacing: AppSpacing.md,
                  childAspectRatio: 0.78,
                ),
                itemBuilder: (context, index) =>
                    ServiceCard(service: items[index].toService()),
              ),
            ],
          ),
      },
    );
  }
}
