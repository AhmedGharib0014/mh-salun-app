import 'package:go_router/go_router.dart';
import 'package:mh_salun/features/auth/presentation/login_page.dart';
import 'package:mh_salun/features/auth/presentation/register_page.dart';
import 'package:mh_salun/features/auth/presentation/reset_password_page.dart';
import 'package:mh_salun/features/home/presentation/home_page.dart';
import 'package:mh_salun/features/splash/presentation/splash_page.dart';

class AppRoutes {
  static const splash = 'splash';
  static const home = 'home';
  static const login = 'login';
  static const register = 'register';
  static const resetPassword = 'reset-password';
}

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: AppRoutes.splash,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/home',
      name: AppRoutes.home,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/login',
      name: AppRoutes.login,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/register',
      name: AppRoutes.register,
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: '/reset-password',
      name: AppRoutes.resetPassword,
      builder: (context, state) => const ResetPasswordPage(),
    ),
  ],
);
