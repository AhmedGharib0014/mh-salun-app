part of 'reservation_flow_bloc.dart';

sealed class ReservationFlowEvent {}

/// Step 1: the guest picked a branch from the fetched list.
class ReservationBranchSelected extends ReservationFlowEvent {
  ReservationBranchSelected(this.branch);

  final Branch branch;
}

/// Step 2: the guest picked a barber working at the selected branch.
class ReservationBarberSelected extends ReservationFlowEvent {
  ReservationBarberSelected(this.barber);

  final Employee barber;
}

/// Step 3: the guest tapped a service card — added when not yet picked,
/// removed when it was.
class ReservationServiceToggled extends ReservationFlowEvent {
  ReservationServiceToggled(this.service);

  final CatalogItem service;
}

/// Step 4: the guest picked a time slot, or `null` when the selection is
/// cleared (e.g. after switching to another day).
class ReservationSlotSelected extends ReservationFlowEvent {
  ReservationSlotSelected(this.slot);

  final AvailableSlot? slot;
}

/// Drops every selection, for starting the flow over.
class ReservationFlowReset extends ReservationFlowEvent {}
