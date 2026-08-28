import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mh_salun/core/di/injection.dart';
import 'package:mh_salun/core/presentation/widgets/section_loading.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';
import 'package:mh_salun/features/reservations/bloc/available_slots_bloc.dart';
import 'package:mh_salun/features/reservations/bloc/reservation_flow_bloc.dart';
import 'package:mh_salun/features/reservations/model/available_slot.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/booking_calendar.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/booking_step_header.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/step_message.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/time_slot_grid.dart';

/// Step 3 of the new-reservation flow: pick a day from the calendar (from
/// today onward, paging by month) then a single available time slot for it.
///
/// The bookable range and the picked day are the step's own business — the
/// flow never needs them, since [AvailableSlot.startsAt] already carries the
/// full date. Only the chosen slot travels back up, and it comes back null
/// whenever the day changes and the previous pick goes stale.
///
/// Owns its own [AvailableSlotsBloc]: the slots are resolved per day for the
/// branch, barber and services already picked, and are of no use to the rest
/// of the app.
///
/// Reads those earlier picks straight from [ReservationFlowBloc], so the step
/// can only be built once they are answered. Re-keying on them makes a changed
/// selection re-fetch from scratch.
class SelectDateTimeStep extends StatelessWidget {
  const SelectDateTimeStep({super.key});

  @override
  Widget build(BuildContext context) {
    final selection = context.watch<ReservationFlowBloc>().state;
    final branch = selection.branch;
    final barber = selection.barber;
    final services = selection.services;
    if (branch == null || barber == null || services.isEmpty) {
      return const SizedBox.shrink();
    }

    final catalogItemIds = services.map((service) => service.id).toList();
    return BlocProvider(
      key: ValueKey('${branch.id}|${barber.id}|${catalogItemIds.join(',')}'),
      create: (_) => getIt<AvailableSlotsBloc>(),
      child: _SelectDateTimeView(
        branchId: branch.id,
        employeeId: barber.id,
        catalogItemIds: catalogItemIds,
      ),
    );
  }
}

class _SelectDateTimeView extends StatefulWidget {
  const _SelectDateTimeView({
    required this.branchId,
    required this.employeeId,
    required this.catalogItemIds,
  });

  final String branchId;
  final String employeeId;
  final List<String> catalogItemIds;

  @override
  State<_SelectDateTimeView> createState() => _SelectDateTimeViewState();
}

class _SelectDateTimeViewState extends State<_SelectDateTimeView> {
  /// How far ahead the calendar lets the guest book.
  static const int _monthsAhead = 3;

  final DateTime _firstDate = _today();
  late final DateTime _lastDate = DateTime(
    _firstDate.year,
    _firstDate.month + _monthsAhead,
    _firstDate.day,
  );

  late DateTime _selectedDate = _firstDate;

  static DateTime _today() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  @override
  void initState() {
    super.initState();
    _loadSlots();
  }

  void _loadSlots() {
    context.read<AvailableSlotsBloc>().add(
      AvailableSlotsRequested(
        employeeId: widget.employeeId,
        branchId: widget.branchId,
        catalogItemIds: widget.catalogItemIds,
        date: _selectedDate,
      ),
    );
  }

  void _selectSlot(AvailableSlot? slot) =>
      context.read<ReservationFlowBloc>().add(ReservationSlotSelected(slot));

  void _selectDate(DateTime date) {
    setState(() => _selectedDate = date);
    // Slots differ per day; drop the stale choice held by the flow.
    _selectSlot(null);
    _loadSlots();
  }

  @override
  Widget build(BuildContext context) {
    final selectedSlot = context.select<ReservationFlowBloc, AvailableSlot?>(
      (bloc) => bloc.state.slot,
    );

    return ListView(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.md,
          ),
          child: BookingStepHeader(
            titleKey: 'new_reservation_datetime_title',
            subtitleKey: 'new_reservation_datetime_subtitle',
          ),
        ),
        BookingCalendar(
          firstDate: _firstDate,
          lastDate: _lastDate,
          selectedDate: _selectedDate,
          onDateSelected: _selectDate,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.sm,
          ),
          child: Text(
            'new_reservation_times_label'.tr(),
            style: AppTextStyles.titleMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: BlocBuilder<AvailableSlotsBloc, AvailableSlotsState>(
            builder: (context, state) => switch (state) {
              AvailableSlotsFailure(:final messageKey) => StepMessage(
                icon: Icons.error_outline_rounded,
                messageKey: messageKey,
              ),
              AvailableSlotsLoaded(:final slots) => TimeSlotGrid(
                slots: slots,
                selectedSlot: selectedSlot,
                onSlotSelected: _selectSlot,
              ),
              AvailableSlotsInitial() ||
              AvailableSlotsLoading() => const SectionLoading(height: 120),
            },
          ),
        ),
      ],
    );
  }
}
