import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/text_styles.dart';

/// One line of the review step's price breakdown: a label on one side and the
/// formatted amount on the other.
class PriceRow extends StatelessWidget {
  const PriceRow({super.key, required this.label, required this.amountLabel});

  final String label;
  final String amountLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(label, style: AppTextStyles.bodyRegular)),
        const SizedBox(width: 8),
        Text(
          amountLabel,
          style: AppTextStyles.bodyGold.copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
