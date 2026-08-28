import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/features/branches/model/branch.dart';
import 'package:mh_salun/features/employees/model/employee.dart';
import 'package:mh_salun/features/reservations/model/available_slot.dart';
import 'package:mh_salun/features/reservations/model/reservation_step.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/barber_row.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/branch_row.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/date_time_row.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/review_header.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/review_row_divider.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/review_section.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/service_row.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/total_card.dart';
import 'package:mh_salun/features/services/model/catalog_item.dart';
import 'package:mh_salun/features/services/model/catalog_item_x.dart';

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
  final Employee? barber;
  final Set<CatalogItem> services;
  final AvailableSlot? slot;

  /// Called with the step to return to when a section's "Edit" is tapped.
  final ValueChanged<ReservationStep> onEditStep;

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
          onEdit: () => onEditStep(ReservationStep.branch),
          child: BranchRow(branch: branch),
        ),
        const SizedBox(height: AppSpacing.md),
        ReviewSection(
          icon: Icons.person_rounded,
          title: 'new_reservation_review_barber_label'.tr(),
          onEdit: () => onEditStep(ReservationStep.barber),
          child: BarberRow(employee: barber),
        ),
        const SizedBox(height: AppSpacing.md),
        ReviewSection(
          icon: Icons.content_cut_rounded,
          title: 'new_reservation_review_services_label'.tr(),
          onEdit: () => onEditStep(ReservationStep.services),
          child: Column(
            children: [
              for (var i = 0; i < services.length; i++) ...[
                if (i > 0) const ReviewRowDivider(),
                ServiceRow(service: services[i].toService()),
              ],
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        ReviewSection(
          icon: Icons.event_rounded,
          title: 'new_reservation_review_datetime_label'.tr(),
          onEdit: () => onEditStep(ReservationStep.dateTime),
          child: DateTimeRow(dateTimeLabel: _dateTimeLabel(context, slot.startsAt)),
        ),
        const SizedBox(height: AppSpacing.lg),
        TotalCard(totalLabel: _totalLabel(context, services)),
      ],
    );
  }

  /// Sum of [services] prices, formatted with the active locale's digits.
  String _totalLabel(BuildContext context, Iterable<CatalogItem> services) {
    final total = services.fold<double>(0, (sum, item) => sum + item.price);
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
}
