import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../branches/model/branch.dart';
import '../../../employees/model/employee.dart';
import '../../../services/model/catalog_item.dart';
import '../../model/available_slot.dart';
import '../../model/reservation_step.dart';

part 'reservation_flow_event.dart';
part 'reservation_flow_state.dart';

@injectable
class ReservationFlowBloc
    extends Bloc<ReservationFlowEvent, ReservationFlowState> {
  ReservationFlowBloc() : super(const ReservationFlowState()) {
    on<ReservationBranchSelected>(_onBranchSelected);
    on<ReservationBarberSelected>(_onBarberSelected);
    on<ReservationServiceToggled>(_onServiceToggled);
    on<ReservationSlotSelected>(_onSlotSelected);
    on<ReservationFlowReset>(_onReset);
  }

  void _onBranchSelected(
    ReservationBranchSelected event,
    Emitter<ReservationFlowState> emit,
  ) {
    if (state.branch?.id == event.branch.id) return;
    emit(ReservationFlowState(branch: event.branch));
  }

  void _onBarberSelected(
    ReservationBarberSelected event,
    Emitter<ReservationFlowState> emit,
  ) {
    if (state.barber?.id == event.barber.id) return;
    emit(ReservationFlowState(branch: state.branch, barber: event.barber));
  }

  void _onServiceToggled(
    ReservationServiceToggled event,
    Emitter<ReservationFlowState> emit,
  ) {
    final services = Set<CatalogItem>.of(state.services);
    if (!services.remove(event.service)) services.add(event.service);

    emit(
      ReservationFlowState(
        branch: state.branch,
        barber: state.barber,
        services: services,
      ),
    );
  }

  void _onSlotSelected(
    ReservationSlotSelected event,
    Emitter<ReservationFlowState> emit,
  ) {
    emit(
      ReservationFlowState(
        branch: state.branch,
        barber: state.barber,
        services: state.services,
        slot: event.slot,
      ),
    );
  }

  void _onReset(
    ReservationFlowReset event,
    Emitter<ReservationFlowState> emit,
  ) {
    emit(const ReservationFlowState());
  }
}
