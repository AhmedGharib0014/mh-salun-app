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
import 'package:mh_salun/core/di/register_module.dart' as _i511;
import 'package:mh_salun/features/login/bloc/login_bloc.dart' as _i569;
import 'package:mh_salun/features/login/data/login_repository.dart' as _i1060;
import 'package:mh_salun/features/registration/bloc/register_bloc.dart'
    as _i377;
import 'package:mh_salun/features/registration/data/register_repository.dart'
    as _i280;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i1060.LoginRepository>(
      () => _i1060.LoginRepository(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i280.RegisterRepository>(
      () => _i280.RegisterRepository(gh<_i361.Dio>()),
    );
    gh.factory<_i377.RegisterBloc>(
      () => _i377.RegisterBloc(gh<_i280.RegisterRepository>()),
    );
    gh.factory<_i569.LoginBloc>(
      () => _i569.LoginBloc(gh<_i1060.LoginRepository>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i511.RegisterModule {}
