import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../data/available_slots_repository.dart';
import '../../model/available_slot.dart';

part 'available_slots_event.dart';
part 'available_slots_state.dart';

/// Resolves the bookable slots for one day. Scoped to the date-time step of
/// the reservation flow — a new instance per flow, so nothing is cached
/// between bookings.
@injectable
class AvailableSlotsBloc extends Bloc<AvailableSlotsEvent, AvailableSlotsState> {
  AvailableSlotsBloc(this._repo) : super(AvailableSlotsInitial()) {
    on<AvailableSlotsRequested>(_onRequested);
  }

  final AvailableSlotsRepository _repo;

  Future<void> _onRequested(
    AvailableSlotsRequested event,
    Emitter<AvailableSlotsState> emit,
  ) async {
    emit(AvailableSlotsLoading());
    try {
      final result = await _repo.getAvailableSlots(
        employeeId: event.employeeId,
        branchId: event.branchId,
        catalogItemIds: event.catalogItemIds,
        date: event.date,
      );
      emit(AvailableSlotsLoaded(offerId: result.offerId, slots: result.slots));
    } on DioException catch (_) {
      emit(AvailableSlotsFailure('network_error'));
    } catch (_) {
      emit(AvailableSlotsFailure('new_reservation_slots_error'));
    }
  }
}
