import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mh_salun/core/router/app_router.dart';
import 'package:mh_salun/features/account/bloc/profile_bloc.dart';
import 'package:mh_salun/features/auth/bloc/auth_bloc.dart';
import 'package:mh_salun/features/branches/bloc/branches_bloc.dart';
import 'package:mh_salun/features/employees/bloc/employees_bloc.dart';
import 'package:mh_salun/features/home/bloc/home_tab/home_tab_cubit.dart';
import 'package:mh_salun/features/reservations/bloc/reservations_list/reservations_list_bloc.dart';
import 'package:mh_salun/features/services/bloc/services_bloc.dart';

class GlobalListener extends StatelessWidget {
  const GlobalListener({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(listeners: const [_AuthListener()], child: child);
  }
}

class _AuthListener extends BlocListener<AuthBloc, AuthState> {
  const _AuthListener() : super(listener: _onStateChanged);

  static void _onStateChanged(BuildContext context, AuthState state) {
    switch (state) {
      case AuthInitial():
        break;
      case Authenticated():
        appRouter.goNamed(AppRoutes.home);
      case Unauthenticated():
        context.read<EmployeesBloc>().add(EmployeesCleared());
        context.read<ServicesBloc>().add(ServicesCleared());
        context.read<BranchesBloc>().add(BranchesCleared());
        context.read<ProfileBloc>().add(ProfileCleared());
        // Outlives the session, unlike the past list the shell owns.
        context.read<UpcomingReservationsBloc>().add(ReservationsListCleared());
        // The next session starts on the first destination, not wherever the
        // previous one left the shell.
        context.read<HomeTabCubit>().show(HomeTab.home);
        appRouter.goNamed(AppRoutes.login);
    }
  }
}
