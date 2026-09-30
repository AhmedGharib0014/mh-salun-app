part of 'slot_price_bloc.dart';

sealed class SlotPriceEvent {}

/// Dispatched once the review step opens for the slot the guest picked.
class SlotPriceRequested extends SlotPriceEvent {
  SlotPriceRequested(this.timeSlotId);

  final String timeSlotId;
}
