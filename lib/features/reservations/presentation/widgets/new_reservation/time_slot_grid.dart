import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';
import 'package:mh_salun/features/reservations/model/time_slot.dart';

/// Wrapping grid of time-slot chips for the selected day. Unavailable slots
/// are dimmed and non-tappable; the chosen slot is filled gold.
class TimeSlotGrid extends StatelessWidget {
  const TimeSlotGrid({
    super.key,
    required this.slots,
    required this.selectedSlot,
    required this.onSlotSelected,
  });

  final List<TimeSlot> slots;
  final TimeSlot? selectedSlot;
  final ValueChanged<TimeSlot> onSlotSelected;

  @override
  Widget build(BuildContext context) {
    final available = slots.where((slot) => slot.available).toList();
    if (available.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
        child: Center(
          child: Text(
            'new_reservation_no_slots'.tr(),
            style: AppTextStyles.bodySecondary,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

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
            final selected = slot.time == selectedSlot?.time;
            return SizedBox(
              width: itemWidth,
              child: _SlotChip(
                start: format.format(slot.time),
                available: slot.available,
                selected: selected,
                onTap: slot.available ? () => onSlotSelected(slot) : null,
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _SlotChip extends StatelessWidget {
  const _SlotChip({
    required this.start,
    required this.available,
    required this.selected,
    required this.onTap,
  });

  final String start;
  final bool available;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final Color textColor;
    if (!available) {
      textColor = AppColors.onSurface.withValues(alpha: 0.45);
    } else if (selected) {
      textColor = AppColors.onPrimary;
    } else {
      textColor = AppColors.onBackground;
    }

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm + 2),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          border: Border.all(
            color: selected
                ? AppColors.primary
                : AppColors.primary.withValues(alpha: available ? 0.18 : 0.06),
            width: selected ? 2 : 1,
          ),
        ),
        child: Text(
          start,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.bodyRegular.copyWith(
            color: textColor,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            decoration: available ? null : TextDecoration.lineThrough,
          ),
        ),
      ),
    );
  }
}
