part of 'available_slots_bloc.dart';

sealed class AvailableSlotsEvent {}

/// Dispatched whenever the guest picks a day — the slots depend on the chosen
/// barber, branch and services as much as on the date.
class AvailableSlotsRequested extends AvailableSlotsEvent {
  AvailableSlotsRequested({
    required this.employeeId,
    required this.branchId,
    required this.catalogItemIds,
    required this.date,
  });

  final String employeeId;
  final String branchId;
  final List<String> catalogItemIds;
  final DateTime date;
}
