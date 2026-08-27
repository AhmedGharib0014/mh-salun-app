import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/font_sizes.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/home_related/book_now_button.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/home_related/step_chevron.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/home_related/step_chip.dart';

class BookNowContent extends StatelessWidget {
  const BookNowContent({super.key, required this.onStartBooking});

  final VoidCallback onStartBooking;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'home_book_subtitle'.tr(),
          style: const TextStyle(
            fontSize: AppFontSize.caption,
            fontWeight: FontWeight.w700,
            color: AppColors.onPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'home_book_title'.tr(),
          style: const TextStyle(
            fontSize: AppFontSize.display,
            fontWeight: FontWeight.w800,
            color: AppColors.onPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        // Wrap, not Row: the five steps don't fit on one line on narrow
        // phones, so they flow onto a second line instead of overflowing.
        const Wrap(
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xs,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            StepChip(labelKey: 'home_book_step_branch'),
            StepChevron(),
            StepChip(labelKey: 'home_book_step_barber'),
            StepChevron(),
            StepChip(labelKey: 'home_book_step_service'),
            StepChevron(),
            StepChip(labelKey: 'home_book_step_time'),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        BookNowButton(onTap: onStartBooking),
      ],
    );
  }
}
