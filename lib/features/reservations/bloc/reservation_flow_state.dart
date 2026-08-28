part of 'reservation_flow_bloc.dart';

/// The flow's own copy of everything the guest has selected so far. Fields are
/// null / empty until their step is answered, and are cleared again whenever an
/// earlier step changes.
class ReservationFlowState {
  const ReservationFlowState({
    this.branch,
    this.barber,
    this.services = const {},
    this.slot,
  });

  final Branch? branch;
  final Employee? barber;
  final Set<CatalogItem> services;
  final AvailableSlot? slot;

  /// True once every step is answered — i.e. a booking request can be built.
  bool get isComplete =>
      branch != null && barber != null && services.isNotEmpty && slot != null;

  /// Whether [step] holds the selection it asks for, so the flow may move past
  /// it. On [ReservationStep.review] there is nothing left to pick, so this is
  /// simply whether the whole flow is answered.
  bool isAnswered(ReservationStep step) => switch (step) {
    ReservationStep.branch => branch != null,
    ReservationStep.barber => barber != null,
    ReservationStep.services => services.isNotEmpty,
    ReservationStep.dateTime => slot != null,
    ReservationStep.review => isComplete,
  };
}
