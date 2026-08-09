part of 'organization_bloc.dart';

sealed class OrganizationState {}

class OrganizationInitial extends OrganizationState {}

class OrganizationLoading extends OrganizationState {}

class OrganizationLoaded extends OrganizationState {
  OrganizationLoaded(this.organization);

  final OrganizationResponse organization;
}

class OrganizationFailure extends OrganizationState {}
