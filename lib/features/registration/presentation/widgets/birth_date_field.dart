import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';

/// Optional date-of-birth picker, styled to match the app's input fields.
/// Tapping opens a themed [showDatePicker]; not a mandatory field.
class BirthDateField extends StatelessWidget {
  const BirthDateField({super.key, required this.value, required this.onChanged});

  final DateTime? value;
  final ValueChanged<DateTime?> onChanged;

  String _formatted(DateTime date) {
    final d = date.day.toString().padLeft(2, '0');
    final m = date.month.toString().padLeft(2, '0');
    return '$d / $m / ${date.year}';
  }

  Future<void> _pickDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: value ?? DateTime(now.year - 18, now.month, now.day),
      firstDate: DateTime(now.year - 120),
      lastDate: now,
      helpText: 'register_birth_date_label'.tr(),
    );
    if (picked != null) onChanged(picked);
  }

  @override
  Widget build(BuildContext context) {
    final hasValue = value != null;
    return GestureDetector(
      onTap: () => _pickDate(context),
      child: InputDecorator(
        isEmpty: !hasValue,
        decoration: InputDecoration(
          labelText: 'register_birth_date_label'.tr(),
          hintText: 'register_birth_date_hint'.tr(),
          suffixIcon: const Icon(
            Icons.calendar_today_outlined,
            color: AppColors.onSurface,
            size: AppSpacing.iconSm,
          ),
        ),
        child: hasValue
            ? Text(_formatted(value!), style: AppTextStyles.bodyRegular)
            : null,
      ),
    );
  }
}
