import 'package:flutter/material.dart';
import 'package:mh_salun/core/model/barber.dart';
import 'package:mh_salun/core/model/barbers_catalog.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/barber_select_card.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/booking_step_header.dart';

/// Step 1 of the new-reservation flow: pick exactly one barber from a grid of
/// selectable cards. The step sources the roster itself; the flow only cares
/// about which barber came back.
class SelectBarberStep extends StatelessWidget {
  const SelectBarberStep({
    super.key,
    required this.selectedBarber,
    required this.onBarberSelected,
  });

  final Barber? selectedBarber;
  final ValueChanged<Barber> onBarberSelected;

  @override
  Widget build(BuildContext context) {
    final barbers = BarbersCatalog.all();

    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.md,
            ),
            child: BookingStepHeader(
              titleKey: 'new_reservation_barber_title',
              subtitleKey: 'new_reservation_barber_subtitle',
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            0,
            AppSpacing.lg,
            AppSpacing.lg,
          ),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: AppSpacing.md,
              crossAxisSpacing: AppSpacing.md,
              childAspectRatio: 0.92,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final barber = barbers[index];
                return BarberSelectCard(
                  barber: barber,
                  selected: barber == selectedBarber,
                  onTap: () => onBarberSelected(barber),
                );
              },
              childCount: barbers.length,
            ),
          ),
        ),
      ],
    );
  }
}
