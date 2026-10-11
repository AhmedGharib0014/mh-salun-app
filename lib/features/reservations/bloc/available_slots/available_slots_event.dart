part of 'available_slots_bloc.dart';

sealed class AvailableSlotsEvent {}

/// Dispatched whenever the guest picks a day — the slots depend on the chosen
/// barber, branch and services as much as on the date.
///
/// [workingHours] is the branch's weekly schedule; it bounds the day to its
/// shift, which may run past midnight into the next day.
class AvailableSlotsRequested extends AvailableSlotsEvent {
  AvailableSlotsRequested({
    required this.employeeId,
    required this.branchId,
    required this.catalogItemIds,
    required this.date,
    required this.workingHours,
  });

  final String employeeId;
  final String branchId;
  final List<String> catalogItemIds;
  final DateTime date;
  final Map<String, BranchWorkingHours> workingHours;
}
