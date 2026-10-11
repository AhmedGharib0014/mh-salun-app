import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/presentation/widgets/avatar_circle.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';
import 'package:mh_salun/features/employees/model/employee.dart';

/// Read-only barber summary shown in the review step: ringed initial avatar,
/// name and role.
class BarberRow extends StatelessWidget {
  const BarberRow({super.key, required this.employee});

  final Employee employee;

  @override
  Widget build(BuildContext context) {
    final user = employee.user;

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primaryLight, AppColors.primary],
            ),
          ),
          child: AvatarCircle(
            initial: user.firstName.characters.firstOrNull ?? '',
            size: AppSpacing.xxl,
            imageUrl: user.avatarUrl,
            textStyle: AppTextStyles.titleLarge,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${user.firstName} ${user.lastName}',
                style: AppTextStyles.titleMedium.copyWith(
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'new_reservation_review_barber_role'.tr(),
                style: AppTextStyles.caption,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
