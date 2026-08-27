import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';

/// Pin icon followed by a single-line, ellipsized branch address.
class BranchLocationRow extends StatelessWidget {
  const BranchLocationRow({super.key, required this.address});

  final String address;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.location_on_outlined,
          size: AppSpacing.iconSm - 4,
          color: AppColors.onSurface,
        ),
        const SizedBox(width: AppSpacing.xs),
        Flexible(
          child: Text(
            address,
            style: AppTextStyles.caption,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
