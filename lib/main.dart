import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mh_salun/core/di/injection.dart';
import 'package:mh_salun/core/router/app_router.dart';
import 'package:mh_salun/core/storage/local_storage.dart';
import 'package:mh_salun/core/theme/app_theme.dart';
import 'package:mh_salun/features/employees/bloc/employees_bloc.dart';
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
        ],
        child: const MyApp(),
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
