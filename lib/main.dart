import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mh_salun/core/di/injection.dart';
import 'package:mh_salun/core/presentation/global_listener.dart';
import 'package:mh_salun/core/router/app_router.dart';
import 'package:mh_salun/core/storage/local_storage.dart';
import 'package:mh_salun/core/theme/app_theme.dart';
import 'package:mh_salun/features/account/bloc/profile_bloc.dart';
import 'package:mh_salun/features/auth/bloc/auth_bloc.dart';
import 'package:mh_salun/features/branches/bloc/branches_bloc.dart';
import 'package:mh_salun/features/employees/bloc/employees_bloc.dart';
import 'package:mh_salun/features/home/bloc/home_tab/home_tab_cubit.dart';
import 'package:mh_salun/features/reservations/bloc/reservations_list/reservations_list_bloc.dart';
import 'package:mh_salun/features/services/bloc/services_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await EasyLocalization.ensureInitialized();
  await initializeDateFormatting();
  await LocalStorage.init();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar'), Locale('en')],
      path: 'assets/translations',
      startLocale: const Locale('ar'),
      fallbackLocale: const Locale('ar'),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<EmployeesBloc>()),
          BlocProvider(create: (_) => getIt<ServicesBloc>()),
          BlocProvider(create: (_) => getIt<BranchesBloc>()),
          BlocProvider(create: (_) => getIt<ProfileBloc>()),
          BlocProvider(create: (_) => getIt<AuthBloc>()),
          BlocProvider(create: (_) => getIt<HomeTabCubit>()),
          // Above the router: the home card, the upcoming tab and the success
          // page all read this one list.
          BlocProvider(create: (_) => getIt<UpcomingReservationsBloc>()),
        ],
        child: const GlobalListener(child: MyApp()),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'app_title'.tr(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: AppTheme.dark,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}
