import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/model/barber.dart';
import 'package:mh_salun/core/model/service.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/features/branches/model/branch.dart';
import 'package:mh_salun/features/reservations/model/time_slot.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/barber_row.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/branch_row.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/date_time_row.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/review_header.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/review_row_divider.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/review_section.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/service_row.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/total_card.dart';

class ReviewStep extends StatelessWidget {
  const ReviewStep({
    super.key,
    required this.branch,
    required this.barber,
    required this.services,
    required this.slot,
    required this.onEditStep,
  });

  final Branch? branch;
  final Barber? barber;
  final Set<Service> services;
  final TimeSlot? slot;

  /// Called with the step index to return to when a section's "Edit" is tapped
  /// (0 = branch, 1 = barber, 2 = services, 3 = date & time).
  final ValueChanged<int> onEditStep;

  @override
  Widget build(BuildContext context) {
    final branch = this.branch;
    final barber = this.barber;
    final slot = this.slot;
    if (branch == null || barber == null || slot == null) {
      return const SizedBox.shrink();
    }
    final services = this.services.toList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      children: [
        const ReviewHeader(),
        const SizedBox(height: AppSpacing.lg),
        ReviewSection(
          icon: Icons.storefront_rounded,
          title: 'new_reservation_review_branch_label'.tr(),
          onEdit: () => onEditStep(0),
          child: BranchRow(branch: branch),
        ),
        const SizedBox(height: AppSpacing.md),
        ReviewSection(
          icon: Icons.person_rounded,
          title: 'new_reservation_review_barber_label'.tr(),
          onEdit: () => onEditStep(1),
          child: BarberRow(barber: barber),
        ),
        const SizedBox(height: AppSpacing.md),
        ReviewSection(
          icon: Icons.content_cut_rounded,
          title: 'new_reservation_review_services_label'.tr(),
          onEdit: () => onEditStep(2),
          child: Column(
            children: [
              for (var i = 0; i < services.length; i++) ...[
                if (i > 0) const ReviewRowDivider(),
                ServiceRow(service: services[i]),
              ],
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        ReviewSection(
          icon: Icons.event_rounded,
          title: 'new_reservation_review_datetime_label'.tr(),
          onEdit: () => onEditStep(3),
          child: DateTimeRow(dateTimeLabel: _dateTimeLabel(context, slot.time)),
        ),
        const SizedBox(height: AppSpacing.lg),
        TotalCard(totalLabel: _totalLabel(context, services)),
      ],
    );
  }

  /// Sum of [services] prices, formatted with the active locale's digits.
  /// Prices are placeholder strings (e.g. "$25" / "٢٥$"), so we pull the
  /// numeric part out regardless of Western or Arabic-Indic digits.
  String _totalLabel(BuildContext context, Iterable<Service> services) {
    final total = services.fold<int>(
      0,
      (sum, service) => sum + _priceValue(service.price),
    );
    final digits = NumberFormat.decimalPattern(
      context.locale.toString(),
    ).format(total);
    return '\$$digits';
  }

  String _dateTimeLabel(BuildContext context, DateTime time) {
    final locale = context.locale.toString();
    final date = DateFormat('EEE, d MMM', locale).format(time);
    final clock = DateFormat.jm(locale).format(time);
    return '$date · $clock';
  }

  int _priceValue(String raw) {
    const arabicZero = 0x0660;
    final digits = StringBuffer();
    for (final rune in raw.runes) {
      if (rune >= 0x30 && rune <= 0x39) {
        digits.writeCharCode(rune);
      } else if (rune >= arabicZero && rune <= arabicZero + 9) {
        digits.writeCharCode(0x30 + (rune - arabicZero));
      }
    }
    return int.tryParse(digits.toString()) ?? 0;
  }
}
