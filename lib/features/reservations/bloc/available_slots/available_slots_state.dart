part of 'available_slots_bloc.dart';

sealed class AvailableSlotsState {}

class AvailableSlotsInitial extends AvailableSlotsState {}

class AvailableSlotsLoading extends AvailableSlotsState {}

class AvailableSlotsLoaded extends AvailableSlotsState {
  AvailableSlotsLoaded({
    required this.offerId,
    required this.slots,
    required this.overnightSlots,
  });

  /// The offer the returned [slots] belong to — what the booking call refers
  /// back to once the guest confirms.
  final String? offerId;
  final List<AvailableSlot> slots;

  /// Next-day slots that still fall inside the selected day's shift, when it
  /// runs past midnight. Empty when the shift closes the same day.
  final List<AvailableSlot> overnightSlots;
}

class AvailableSlotsFailure extends AvailableSlotsState {
  AvailableSlotsFailure(this.message);

  /// User-facing, display-ready text for the step message.
  final String message;
}
