import 'package:flutter/material.dart';
import 'package:mh_salun/core/model/service.dart';
import 'package:mh_salun/core/theme/text_styles.dart';

/// Gold price label for a [Service].
///
/// Currently unused — service prices are hidden across the UI — but kept as a
/// standalone widget so the display can be switched back on without rewriting
/// it. It was previously rendered inline by `ServiceCard`, `ServiceRow` and
/// `ServiceSelectCard`.
class ServicePriceLabel extends StatelessWidget {
  const ServicePriceLabel({super.key, required this.service, this.style});

  final Service service;

  /// Base style to apply; defaults to [AppTextStyles.bodyGold]. `ServiceCard`
  /// used [AppTextStyles.titleGold] with `height: ServiceCard.lineHeight`.
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      service.price,
      style: (style ?? AppTextStyles.bodyGold).copyWith(
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
