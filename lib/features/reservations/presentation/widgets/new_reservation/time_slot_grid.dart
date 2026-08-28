import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/features/reservations/model/available_slot.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/no_slots_message.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/slot_chip.dart';

/// Wrapping grid of time-slot chips for the selected day. Every slot the
/// backend returns is bookable, so there is no dimmed state — the chosen slot
/// is filled gold.
class TimeSlotGrid extends StatelessWidget {
  const TimeSlotGrid({
    super.key,
    required this.slots,
    required this.selectedSlot,
    required this.onSlotSelected,
  });

  final List<AvailableSlot> slots;
  final AvailableSlot? selectedSlot;
  final ValueChanged<AvailableSlot> onSlotSelected;

  @override
  Widget build(BuildContext context) {
    if (slots.isEmpty) return const NoSlotsMessage();

    final locale = context.locale.toString();
    final format = DateFormat.jm(locale);
    const columns = 3;
    const spacing = AppSpacing.sm;

    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth =
            (constraints.maxWidth - spacing * (columns - 1)) / columns;
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: slots.map((slot) {
            return SizedBox(
              width: itemWidth,
              child: SlotChip(
                start: format.format(slot.startsAt),
                selected: slot.id == selectedSlot?.id,
                onTap: () => onSlotSelected(slot),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
