part of 'organization_bloc.dart';

sealed class OrganizationEvent {}

/// Dispatched when the home screen needs the organization loaded.
class OrganizationRequested extends OrganizationEvent {}
