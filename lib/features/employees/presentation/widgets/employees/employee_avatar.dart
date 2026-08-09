import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';
import 'package:mh_salun/features/employees/model/employee.dart';

class EmployeeAvatar extends StatelessWidget {
  const EmployeeAvatar({super.key, required this.employee});

  final Employee employee;

  @override
  Widget build(BuildContext context) {
    final name = '${employee.user.firstName} ${employee.user.lastName}';
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
            child: Text(
              employee.user.firstName.substring(0, 1),
              style: AppTextStyles.headingLarge,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            name,
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
                employee.ratingAvg.toStringAsFixed(1),
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
