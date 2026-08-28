import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mh_salun/core/presentation/widgets/section_loading.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/features/employees/model/employee.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/booking_step_header.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/service_select_card.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/step_message.dart';
import 'package:mh_salun/features/services/bloc/services_bloc.dart';
import 'package:mh_salun/features/services/model/catalog_item.dart';
import 'package:mh_salun/features/services/model/catalog_item_x.dart';

class SelectServicesStep extends StatelessWidget {
  const SelectServicesStep({
    super.key,
    required this.barber,
    required this.selectedServices,
    required this.onServiceToggled,
  });

  final Employee? barber;
  final Set<CatalogItem> selectedServices;
  final ValueChanged<CatalogItem> onServiceToggled;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServicesBloc, ServicesState>(
      builder: (context, state) {
        // The catalog narrowed to what the selected barber offers.
        final offeredIds = barber?.catalogItemIds.toSet() ?? const {};
        final offered = switch (state) {
          ServicesLoaded(:final items) =>
            items.where((item) => offeredIds.contains(item.id)).toList(),
          _ => const <CatalogItem>[],
        };

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
                ServicesLoaded() when offered.isEmpty => const StepMessage(
                  icon: Icons.content_cut_rounded,
                  messageKey: 'new_reservation_service_empty',
                ),
                ServicesLoaded() => ListView.separated(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    0,
                    AppSpacing.lg,
                    AppSpacing.lg,
                  ),
                  itemCount: offered.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: AppSpacing.md),
                  itemBuilder: (context, index) {
                    final item = offered[index];
                    return ServiceSelectCard(
                      service: item.toService(),
                      selected: selectedServices.contains(item),
                      onTap: () => onServiceToggled(item),
                    );
                  },
                ),
                ServicesInitial() || ServicesLoading() => const SectionLoading(
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
