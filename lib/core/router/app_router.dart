import 'package:go_router/go_router.dart';
import 'package:mh_salun/features/home/presentation/home_page.dart';

class AppRoutes {
  static const home = 'home';
}

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: AppRoutes.home,
      builder: (context, state) => const HomePage(),
    ),
  ],
);
