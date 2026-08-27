import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';
import 'package:mh_salun/features/branches/model/branch_working_hours.dart';

class BranchWorkingHoursRow extends StatelessWidget {
  const BranchWorkingHoursRow({
    super.key,
    required this.day,
    required this.hours,
  });

  final String day;
  final BranchWorkingHours? hours;

  String get _dayLabel =>
      '${day.substring(0, 1)}${day.substring(1).toLowerCase()}';

  String _formatTime(String time) {
    final parts = time.split(':');
    final hour = int.parse(parts[0]);
    final minute = parts[1];
    final period = hour >= 12 ? 'PM' : 'AM';
    final hour12 = hour % 12 == 0 ? 12 : hour % 12;
    return '$hour12:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    final hours = this.hours;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(_dayLabel, style: AppTextStyles.bodyRegular),
          Text(
            hours == null
                ? 'branch_details_closed'.tr()
                : '${_formatTime(hours.openingTime)} – ${_formatTime(hours.closingTime)}',
            style: hours == null
                ? AppTextStyles.caption
                : AppTextStyles.bodySecondary,
          ),
        ],
      ),
    );
  }
}
