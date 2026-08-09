part of 'services_bloc.dart';

sealed class ServicesState {}

class ServicesInitial extends ServicesState {}

class ServicesLoading extends ServicesState {}

class ServicesLoaded extends ServicesState {
  ServicesLoaded(this.items);

  final List<CatalogItem> items;
}

class ServicesFailure extends ServicesState {
  ServicesFailure(this.messageKey);

  final String messageKey;
}
