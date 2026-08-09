import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../core/data/organization_repository.dart';
import '../../../core/model/organization_response.dart';

part 'organization_event.dart';
part 'organization_state.dart';

@injectable
class OrganizationBloc extends Bloc<OrganizationEvent, OrganizationState> {
  OrganizationBloc(this._repo) : super(OrganizationInitial()) {
    on<OrganizationRequested>(_onRequested);
  }

  final OrganizationRepository _repo;

  Future<void> _onRequested(
    OrganizationRequested event,
    Emitter<OrganizationState> emit,
  ) async {
    emit(OrganizationLoading());
    try {
      final organization = await _repo.getOrganization();
      emit(OrganizationLoaded(organization));
    } on DioException catch (_) {
      _emitCachedOrFailure(emit, 'network_error');
    } catch (_) {
      _emitCachedOrFailure(emit, 'organization_generic_error');
    }
  }

  void _emitCachedOrFailure(
    Emitter<OrganizationState> emit,
    String messageKey,
  ) {
    final cached = _repo.cachedOrganization;
    if (cached != null) {
      emit(OrganizationLoaded(cached));
    } else {
      emit(OrganizationFailure(messageKey));
    }
  }
}
