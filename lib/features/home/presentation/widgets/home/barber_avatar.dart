import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';
import 'package:mh_salun/features/home/model/barber.dart';

class BarberAvatar extends StatelessWidget {
  const BarberAvatar({super.key, required this.barber});

  final Barber barber;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 96,
      child: Column(
        children: [
          Container(
            width: 74,
            height: 74,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.surfaceHigh,
              border: Border.all(color: AppColors.primary, width: 2),
            ),
            alignment: Alignment.center,
            child: Text(barber.initial, style: AppTextStyles.headingLarge),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            barber.name,
            style: AppTextStyles.bodyRegular.copyWith(fontWeight: FontWeight.w700, height: 1.2),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                barber.rating,
                style: AppTextStyles.bodyGold.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 2),
              const Icon(Icons.star, size: AppSpacing.iconSm - 4, color: AppColors.primary),
            ],
          ),
        ],
      ),
    );
  }
}
