part of 'services_bloc.dart';

sealed class ServicesEvent {}

/// Dispatched when the catalog items for an organization are needed.
class ServicesRequested extends ServicesEvent {
  ServicesRequested(this.organizationId);

  final String organizationId;
}

/// Dispatched on a new successful login to drop the previous organization's
/// cached services before the new one is loaded.
class ServicesCleared extends ServicesEvent {}
