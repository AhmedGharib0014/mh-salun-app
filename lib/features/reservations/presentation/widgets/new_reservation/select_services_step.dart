import 'package:flutter/material.dart';
import 'package:mh_salun/core/model/service.dart';
import 'package:mh_salun/core/model/services_catalog.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/booking_step_header.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/service_select_card.dart';

/// Step 2 of the new-reservation flow: pick one or more services. Each row
/// toggles independently so the guest can combine services in one booking.
/// The step sources the menu itself; the flow only tracks the picked services,
/// which it needs for the footer total and the review recap.
class SelectServicesStep extends StatelessWidget {
  const SelectServicesStep({
    super.key,
    required this.selectedServices,
    required this.onServiceToggled,
  });

  final Set<Service> selectedServices;
  final ValueChanged<Service> onServiceToggled;

  @override
  Widget build(BuildContext context) {
    final services = ServicesCatalog.all();

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      itemCount: services.length + 1,
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppSpacing.md),
      itemBuilder: (context, index) {
        if (index == 0) {
          return const Padding(
            padding: EdgeInsets.only(bottom: AppSpacing.xs),
            child: BookingStepHeader(
              titleKey: 'new_reservation_service_title',
              subtitleKey: 'new_reservation_service_subtitle',
            ),
          );
        }
        final service = services[index - 1];
        return ServiceSelectCard(
          service: service,
          selected: selectedServices.contains(service),
          onTap: () => onServiceToggled(service),
        );
      },
    );
  }
}
