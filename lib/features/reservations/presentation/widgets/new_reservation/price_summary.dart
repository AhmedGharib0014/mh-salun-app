import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mh_salun/core/di/injection.dart';
import 'package:mh_salun/core/presentation/widgets/section_loading.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/utils/currency.dart';
import 'package:mh_salun/features/reservations/bloc/slot_price/slot_price_bloc.dart';
import 'package:mh_salun/features/reservations/model/slot_price.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/price_row.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/review_row_divider.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/review_section.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/step_message.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/total_card.dart';

/// Closing block of the review step: the services cost, the app fee and the
/// total, all as priced by the backend for the picked slot.
///
/// Owns its own [SlotPriceBloc] and fetches on build, re-keyed on the slot so
/// a changed pick re-prices. The amounts are never computed in the app.
class PriceSummary extends StatelessWidget {
  const PriceSummary({super.key, required this.timeSlotId});

  final String timeSlotId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      key: ValueKey(timeSlotId),
      create: (_) =>
          getIt<SlotPriceBloc>()..add(SlotPriceRequested(timeSlotId)),
      child: const _PriceSummaryView(),
    );
  }
}

class _PriceSummaryView extends StatelessWidget {
  const _PriceSummaryView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SlotPriceBloc, SlotPriceState>(
      builder: (context, state) => switch (state) {
        SlotPriceFailure(:final message) => StepMessage(
          icon: Icons.error_outline_rounded,
          message: message,
        ),
        SlotPriceLoaded(:final price) => _Breakdown(price: price),
        SlotPriceInitial() ||
        SlotPriceLoading() => const SectionLoading(height: 140),
      },
    );
  }
}

class _Breakdown extends StatelessWidget {
  const _Breakdown({required this.price});

  final SlotPrice price;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ReviewSection(
          icon: Icons.receipt_long_rounded,
          title: 'new_reservation_review_price_label'.tr(),
          child: Column(
            children: [
              PriceRow(
                label: 'new_reservation_review_services_cost_label'.tr(),
                amountLabel: _amount(context, price.servicesCost),
              ),
              const ReviewRowDivider(),
              PriceRow(
                label: 'new_reservation_review_app_fee_label'.tr(),
                amountLabel: _amount(context, price.appFee),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        TotalCard(totalLabel: _amount(context, price.total)),
      ],
    );
  }

  /// Formats [value] with the active locale's digits and the currency sign.
  String _amount(BuildContext context, num value) {
    final digits = NumberFormat.decimalPattern(
      context.locale.toString(),
    ).format(value);
    return '$digits $currencySymbol';
  }
}
