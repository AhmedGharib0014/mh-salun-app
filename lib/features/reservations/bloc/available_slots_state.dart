part of 'available_slots_bloc.dart';

sealed class AvailableSlotsState {}

class AvailableSlotsInitial extends AvailableSlotsState {}

class AvailableSlotsLoading extends AvailableSlotsState {}

class AvailableSlotsLoaded extends AvailableSlotsState {
  AvailableSlotsLoaded({required this.offerId, required this.slots});

  /// The offer the returned [slots] belong to — what the booking call refers
  /// back to once the guest confirms.
  final String offerId;
  final List<AvailableSlot> slots;
}

class AvailableSlotsFailure extends AvailableSlotsState {
  AvailableSlotsFailure(this.messageKey);

  final String messageKey;
}
