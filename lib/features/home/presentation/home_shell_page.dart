import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mh_salun/core/di/injection.dart';
import 'package:mh_salun/core/presentation/widgets/app_error_dialog.dart';
import 'package:mh_salun/core/router/app_router.dart';
import 'package:mh_salun/features/account/bloc/profile_bloc.dart';
import 'package:mh_salun/features/account/presentation/account_tab_view.dart';
import 'package:mh_salun/features/branches/bloc/branches_bloc.dart';
import 'package:mh_salun/features/employees/bloc/employees_bloc.dart';
import 'package:mh_salun/features/home/bloc/organization_bloc.dart';
import 'package:mh_salun/features/home/presentation/home_tab_view.dart';
import 'package:mh_salun/features/home/presentation/widgets/home/home_bottom_nav.dart';
import 'package:mh_salun/features/reservations/presentation/reservations_tab_view.dart';
import 'package:mh_salun/features/services/bloc/services_bloc.dart';
import 'package:mh_salun/features/services/presentation/services_tab_view.dart';

/// Persistent shell owning the bottom nav bar and the in-place tab content.
/// Switching destinations only swaps the current [PageView] page — it
/// never pushes a new route.
class HomeShellPage extends StatefulWidget {
  const HomeShellPage({super.key, this.initialTab = 0});

  /// Destination the shell opens on — see [AppRoutes.reservationsTab] for the
  /// indices other screens navigate to.
  final int initialTab;

  @override
  State<HomeShellPage> createState() => _HomeShellPageState();
}

class _HomeShellPageState extends State<HomeShellPage> {
  late final _pageController = PageController(initialPage: widget.initialTab);
  late final OrganizationBloc _organizationBloc;
  late int _currentIndex = widget.initialTab;

  @override
  void initState() {
    super.initState();
    _organizationBloc = getIt<OrganizationBloc>()..add(OrganizationRequested());
    getIt<ProfileBloc>().add(ProfileRequested());
  }

  @override
  void dispose() {
    _pageController.dispose();
    _organizationBloc.close();
    super.dispose();
  }

  void _goToTab(int index) {
    setState(() => _currentIndex = index);
    _pageController.jumpToPage(index);
  }

  void _onNavSelected(int index) => _goToTab(index);

  void _onStartBooking() => context.pushNamed(AppRoutes.newReservation);

  void _onAddTap() => _onStartBooking();

  void _onOrganizationChanged(BuildContext context, OrganizationState state) {
    if (state is OrganizationLoaded) {
      final orgId = state.organization.id;
      context.read<EmployeesBloc>().add(EmployeesRequested(orgId));
      context.read<ServicesBloc>().add(ServicesRequested(orgId));
      context.read<BranchesBloc>().add(BranchesRequested(orgId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _organizationBloc,
      child: MultiBlocListener(
        listeners: [
          BlocListener<OrganizationBloc, OrganizationState>(
            listener: _onOrganizationChanged,
          ),
          BlocListener<EmployeesBloc, EmployeesState>(
            listener: (context, state) {
              if (state is EmployeesFailure) {
                AppErrorDialog.show(context, state.messageKey);
              }
            },
          ),
          BlocListener<ServicesBloc, ServicesState>(
            listener: (context, state) {
              if (state is ServicesFailure) {
                AppErrorDialog.show(context, state.messageKey);
              }
            },
          ),
          BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is ProfileFailure) {
                AppErrorDialog.show(context, state.messageKey);
              }
            },
          ),
        ],
        child: Scaffold(
          extendBody: true,
          body: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (index) => setState(() => _currentIndex = index),
            children: [
              HomeTabView(onSeeAllServices: () => _goToTab(1)),
              const ServicesTabView(),
              ReservationsTabView(onStartBooking: _onStartBooking),
              const AccountTabView(),
            ],
          ),
          bottomNavigationBar: HomeBottomNav(
            selectedIndex: _currentIndex,
            onDestinationSelected: _onNavSelected,
            onAddTap: _onAddTap,
          ),
        ),
      ),
    );
  }
}
