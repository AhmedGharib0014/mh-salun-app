import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/data/api_exception.dart';
import '../../../branches/model/branch_working_hours.dart';
import '../../data/available_slots_repository.dart';
import '../../model/available_slot.dart';
import '../../model/available_slots_response.dart';

part 'available_slots_event.dart';
part 'available_slots_state.dart';

@injectable
class AvailableSlotsBloc
    extends Bloc<AvailableSlotsEvent, AvailableSlotsState> {
  AvailableSlotsBloc(this._repo) : super(AvailableSlotsInitial()) {
    on<AvailableSlotsRequested>(_loadSlotsForBusinessDay);
  }

  final AvailableSlotsRepository _repo;

  static const _weekdayKeys = [
    'MONDAY',
    'TUESDAY',
    'WEDNESDAY',
    'THURSDAY',
    'FRIDAY',
    'SATURDAY',
    'SUNDAY',
  ];

  static const _noSlots = <AvailableSlot>[];

  Future<void> _loadSlotsForBusinessDay(
    AvailableSlotsRequested event,
    Emitter<AvailableSlotsState> emit,
  ) async {
    emit(AvailableSlotsLoading());

    try {
      final (selectedDay, overnightSlots) = await (
        _fetchSlotsOn(event.date, event),
        _fetchOvernightSlotsIfShiftPassesMidnight(event),
      ).wait;

      emit(
        AvailableSlotsLoaded(
          offerId: selectedDay.offerId,
          slots: selectedDay.slots,
          overnightSlots: overnightSlots,
        ),
      );
    } on ParallelWaitError<Object?, (AsyncError?, AsyncError?)> catch (e) {
      final selectedDayError = e.errors.$1?.error;
      emit(AvailableSlotsFailure(_failureMessageFor(selectedDayError)));
    } catch (e) {
      emit(AvailableSlotsFailure(_failureMessageFor(e)));
    }
  }

  static String _failureMessageFor(Object? error) => error is ApiException
      ? error.message
      : 'new_reservation_slots_error'.tr();

  Future<List<AvailableSlot>> _fetchOvernightSlotsIfShiftPassesMidnight(
    AvailableSlotsRequested event,
  ) {
    final overnightShiftEnd = _overnightShiftEndOrNull(
      event.date,
      event.workingHours,
    );
    if (overnightShiftEnd == null) return Future.value(_noSlots);
    return _fetchNextDaySlotsStartingBefore(overnightShiftEnd, event);
  }

  Future<List<AvailableSlot>> _fetchNextDaySlotsStartingBefore(
    DateTime shiftEnd,
    AvailableSlotsRequested event,
  ) async {
    try {
      final nextDay = await _fetchSlotsOn(_dayAfter(event.date), event);
      return nextDay.slots
          .where((slot) => slot.startsAt.toLocal().isBefore(shiftEnd))
          .toList();
    } catch (_) {
      return _noSlots;
    }
  }

  Future<AvailableSlotsResponse> _fetchSlotsOn(
    DateTime date,
    AvailableSlotsRequested event,
  ) => _repo.getAvailableSlots(
    employeeId: event.employeeId,
    branchId: event.branchId,
    catalogItemIds: event.catalogItemIds,
    date: date,
  );

  static DateTime? _overnightShiftEndOrNull(
    DateTime date,
    Map<String, BranchWorkingHours> workingHours,
  ) {
    final hours = _workingHoursOn(date, workingHours);
    if (hours == null) return null;

    final opensAt = _dateAtTime(date, hours.openingTime);
    final closesAt = _dateAtTime(date, hours.closingTime);
    final closesSameDay = closesAt.isAfter(opensAt);
    if (closesSameDay) return null;

    return closesAt.add(const Duration(days: 1));
  }

  static BranchWorkingHours? _workingHoursOn(
    DateTime date,
    Map<String, BranchWorkingHours> workingHours,
  ) => workingHours[_weekdayKeys[date.weekday - DateTime.monday]];

  static DateTime _dayAfter(DateTime date) =>
      DateTime(date.year, date.month, date.day + 1);

  static DateTime _dateAtTime(DateTime date, String hhMm) {
    final [hours, minutes, ...] = hhMm.split(':').map(int.parse).toList();
    return DateTime(date.year, date.month, date.day, hours, minutes);
  }
}
