part of 'slot_price_bloc.dart';

sealed class SlotPriceState {}

class SlotPriceInitial extends SlotPriceState {}

class SlotPriceLoading extends SlotPriceState {}

class SlotPriceLoaded extends SlotPriceState {
  SlotPriceLoaded(this.price);

  final SlotPrice price;
}

class SlotPriceFailure extends SlotPriceState {
  SlotPriceFailure(this.message);

  /// User-facing, display-ready text for the step message.
  final String message;
}
