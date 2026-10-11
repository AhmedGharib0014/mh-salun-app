import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/features/reservations/model/available_slot.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/slot_chip.dart';

/// Three-column wrap of [SlotChip]s for one group of slots, times printed
/// with [format]. The chip matching [selectedSlot] is shown as chosen.
class SlotWrap extends StatelessWidget {
  const SlotWrap({
    super.key,
    required this.slots,
    required this.format,
    required this.selectedSlot,
    required this.onSlotSelected,
  });

  final List<AvailableSlot> slots;
  final DateFormat format;
  final AvailableSlot? selectedSlot;
  final ValueChanged<AvailableSlot> onSlotSelected;

  @override
  Widget build(BuildContext context) {
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
