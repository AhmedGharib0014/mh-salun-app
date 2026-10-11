import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';
import 'package:mh_salun/features/reservations/model/available_slot.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/no_slots_message.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/slot_wrap.dart';

/// Wrapping grid of time-slot chips for the selected day, followed by the
/// next day's [overnightSlots] under their own "Next day" label when the
/// shift runs past midnight. Every slot the backend returns is bookable, so
/// there is no dimmed state — the chosen slot is filled gold.
class TimeSlotGrid extends StatelessWidget {
  const TimeSlotGrid({
    super.key,
    required this.slots,
    required this.overnightSlots,
    required this.selectedSlot,
    required this.onSlotSelected,
  });

  final List<AvailableSlot> slots;
  final List<AvailableSlot> overnightSlots;
  final AvailableSlot? selectedSlot;
  final ValueChanged<AvailableSlot> onSlotSelected;

  @override
  Widget build(BuildContext context) {
    if (slots.isEmpty && overnightSlots.isEmpty) return const NoSlotsMessage();

    final locale = context.locale.toString();
    final format = DateFormat.jm(locale);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (slots.isNotEmpty)
          SlotWrap(
            slots: slots,
            format: format,
            selectedSlot: selectedSlot,
            onSlotSelected: onSlotSelected,
          ),
        if (overnightSlots.isNotEmpty) ...[
          Padding(
            padding: EdgeInsets.only(
              top: slots.isEmpty ? 0 : AppSpacing.md,
              bottom: AppSpacing.sm,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.nightlight_round,
                  size: AppSpacing.iconSm,
                  color: AppColors.primary.withValues(alpha: 0.8),
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  'new_reservation_next_day_label'.tr(
                    args: [
                      DateFormat(
                        'EEE, d MMM',
                        locale,
                      ).format(overnightSlots.first.startsAt),
                    ],
                  ),
                  style: AppTextStyles.bodySecondary,
                ),
              ],
            ),
          ),
          SlotWrap(
            slots: overnightSlots,
            format: format,
            selectedSlot: selectedSlot,
            onSlotSelected: onSlotSelected,
          ),
        ],
      ],
    );
  }
}
