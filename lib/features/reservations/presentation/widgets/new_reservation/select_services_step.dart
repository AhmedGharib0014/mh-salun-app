import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mh_salun/core/presentation/widgets/section_loading.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/booking_step_header.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/service_select_card.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/step_message.dart';
import 'package:mh_salun/features/services/bloc/services_bloc.dart';
import 'package:mh_salun/features/services/model/catalog_item.dart';
import 'package:mh_salun/features/services/model/catalog_item_x.dart';

/// Step 3 of the new-reservation flow: pick one or more services. Each row
/// toggles independently so the guest can combine services in one booking.
/// Reads the app-wide `ServicesBloc` (already loaded for the home screen), so
/// it neither owns nor closes it nor triggers the fetch itself; the flow only
/// tracks the picked services, which it needs for the review recap.
class SelectServicesStep extends StatelessWidget {
  const SelectServicesStep({
    super.key,
    required this.selectedServices,
    required this.onServiceToggled,
  });

  final Set<CatalogItem> selectedServices;
  final ValueChanged<CatalogItem> onServiceToggled;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServicesBloc, ServicesState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.md,
              ),
              child: BookingStepHeader(
                titleKey: 'new_reservation_service_title',
                subtitleKey: 'new_reservation_service_subtitle',
              ),
            ),
            Expanded(
              child: switch (state) {
                ServicesFailure(:final messageKey) => StepMessage(
                  icon: Icons.error_outline_rounded,
                  messageKey: messageKey,
                ),
                ServicesLoaded(:final items) when items.isEmpty =>
                  const StepMessage(
                    icon: Icons.content_cut_rounded,
                    messageKey: 'new_reservation_service_empty',
                  ),
                ServicesLoaded(:final items) => ListView.separated(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    0,
                    AppSpacing.lg,
                    AppSpacing.lg,
                  ),
                  itemCount: items.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: AppSpacing.md),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ServiceSelectCard(
                      service: item.toService(),
                      selected: selectedServices.contains(item),
                      onTap: () => onServiceToggled(item),
                    );
                  },
                ),
                ServicesInitial() ||
                ServicesLoading() => const SectionLoading(
                  height: double.infinity,
                ),
              },
            ),
          ],
        );
      },
    );
  }
}
