import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/data/api_exception.dart';
import '../../data/available_slots_repository.dart';
import '../../model/slot_price.dart';

part 'slot_price_event.dart';
part 'slot_price_state.dart';

/// Resolves what the picked slot costs. Scoped to the review step of the
/// reservation flow — the backend, not the app, decides the amounts.
@injectable
class SlotPriceBloc extends Bloc<SlotPriceEvent, SlotPriceState> {
  SlotPriceBloc(this._repo) : super(SlotPriceInitial()) {
    on<SlotPriceRequested>(_onRequested);
  }

  final AvailableSlotsRepository _repo;

  Future<void> _onRequested(
    SlotPriceRequested event,
    Emitter<SlotPriceState> emit,
  ) async {
    emit(SlotPriceLoading());
    try {
      final price = await _repo.getSlotPrice(timeSlotId: event.timeSlotId);
      emit(SlotPriceLoaded(price));
    } on ApiException catch (e) {
      emit(SlotPriceFailure(e.message));
    } catch (_) {
      emit(SlotPriceFailure('new_reservation_review_price_error'.tr()));
    }
  }
}
