// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:mh_salun/core/data/organization_repository.dart' as _i445;
import 'package:mh_salun/core/data/token_storage.dart' as _i724;
import 'package:mh_salun/core/di/register_module.dart' as _i511;
import 'package:mh_salun/features/account/bloc/profile_bloc.dart' as _i854;
import 'package:mh_salun/features/account/data/profile_repository.dart'
    as _i257;
import 'package:mh_salun/features/auth/bloc/auth_bloc.dart' as _i835;
import 'package:mh_salun/features/branches/bloc/branches_bloc.dart' as _i589;
import 'package:mh_salun/features/branches/data/branch_repository.dart'
    as _i158;
import 'package:mh_salun/features/employees/bloc/employees_bloc.dart' as _i520;
import 'package:mh_salun/features/employees/data/employee_repository.dart'
    as _i920;
import 'package:mh_salun/features/home/bloc/organization_bloc.dart' as _i587;
import 'package:mh_salun/features/login/bloc/login_bloc.dart' as _i569;
import 'package:mh_salun/features/login/data/login_repository.dart' as _i1060;
import 'package:mh_salun/features/registration/bloc/register_bloc.dart'
    as _i377;
import 'package:mh_salun/features/registration/data/register_repository.dart'
    as _i280;
import 'package:mh_salun/features/reservations/bloc/available_slots_bloc.dart'
    as _i733;
import 'package:mh_salun/features/reservations/bloc/reservation_flow_bloc.dart'
    as _i1066;
import 'package:mh_salun/features/reservations/data/available_slots_repository.dart'
    as _i7;
import 'package:mh_salun/features/services/bloc/services_bloc.dart' as _i448;
import 'package:mh_salun/features/services/data/catalog_item_repository.dart'
    as _i662;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.factory<_i1066.ReservationFlowBloc>(() => _i1066.ReservationFlowBloc());
    gh.lazySingleton<_i724.TokenStorage>(() => _i724.TokenStorage());
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i445.OrganizationRepository>(
      () => _i445.OrganizationRepository(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i257.ProfileRepository>(
      () => _i257.ProfileRepository(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i158.BranchRepository>(
      () => _i158.BranchRepository(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i920.EmployeeRepository>(
      () => _i920.EmployeeRepository(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i280.RegisterRepository>(
      () => _i280.RegisterRepository(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i7.AvailableSlotsRepository>(
      () => _i7.AvailableSlotsRepository(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i662.CatalogItemRepository>(
      () => _i662.CatalogItemRepository(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i520.EmployeesBloc>(
      () => _i520.EmployeesBloc(gh<_i920.EmployeeRepository>()),
    );
    gh.factory<_i377.RegisterBloc>(
      () => _i377.RegisterBloc(gh<_i280.RegisterRepository>()),
    );
    gh.factory<_i733.AvailableSlotsBloc>(
      () => _i733.AvailableSlotsBloc(gh<_i7.AvailableSlotsRepository>()),
    );
    gh.lazySingleton<_i1060.LoginRepository>(
      () => _i1060.LoginRepository(gh<_i361.Dio>(), gh<_i724.TokenStorage>()),
    );
    gh.lazySingleton<_i589.BranchesBloc>(
      () => _i589.BranchesBloc(gh<_i158.BranchRepository>()),
    );
    gh.factory<_i587.OrganizationBloc>(
      () => _i587.OrganizationBloc(gh<_i445.OrganizationRepository>()),
    );
    gh.lazySingleton<_i835.AuthBloc>(
      () => _i835.AuthBloc(gh<_i724.TokenStorage>()),
    );
    gh.lazySingleton<_i854.ProfileBloc>(
      () => _i854.ProfileBloc(gh<_i257.ProfileRepository>()),
    );
    gh.lazySingleton<_i448.ServicesBloc>(
      () => _i448.ServicesBloc(gh<_i662.CatalogItemRepository>()),
    );
    gh.factory<_i569.LoginBloc>(
      () => _i569.LoginBloc(gh<_i1060.LoginRepository>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i511.RegisterModule {}
