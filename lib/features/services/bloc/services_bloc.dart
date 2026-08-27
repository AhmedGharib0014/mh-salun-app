import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../data/catalog_item_repository.dart';
import '../model/catalog_item.dart';

part 'services_event.dart';
part 'services_state.dart';

/// Shared app-wide bloc: services are loaded once per organization and
/// reused across every screen that needs them (home, services tab, ...).
@lazySingleton
class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  ServicesBloc(this._repo) : super(ServicesInitial()) {
    on<ServicesRequested>(_onRequested);
    on<ServicesCleared>(_onCleared);
  }

  final CatalogItemRepository _repo;

  /// Cached services, kept independent of the bloc state so other flows
  /// (e.g. the booking cycle) can read them without listening for state.
  List<CatalogItem> _items = [];
  List<CatalogItem> get items => _items;

  Future<void> _onRequested(
    ServicesRequested event,
    Emitter<ServicesState> emit,
  ) async {
    emit(ServicesLoading());
    try {
      final items = await _repo.getCatalogItems(
        organizationId: event.organizationId,
      );
      _items = items;
      emit(ServicesLoaded(items));
    } on DioException catch (_) {
      emit(ServicesFailure('network_error'));
    } catch (_) {
      emit(ServicesFailure('services_generic_error'));
    }
  }

  void _onCleared(ServicesCleared event, Emitter<ServicesState> emit) {
    _items = [];
    emit(ServicesInitial());
  }
}
