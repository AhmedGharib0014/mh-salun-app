import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mh_salun/core/router/app_router.dart';
import 'package:mh_salun/features/account/bloc/profile_bloc.dart';
import 'package:mh_salun/features/auth/bloc/auth_bloc.dart';
import 'package:mh_salun/features/branches/bloc/branches_bloc.dart';
import 'package:mh_salun/features/employees/bloc/employees_bloc.dart';
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
        appRouter.goNamed(AppRoutes.login);
    }
  }
}
