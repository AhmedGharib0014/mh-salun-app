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
import 'package:mh_salun/features/home/bloc/home_tab/home_tab_cubit.dart';
import 'package:mh_salun/features/home/bloc/organization/organization_bloc.dart';
import 'package:mh_salun/features/home/presentation/home_tab_view.dart';
import 'package:mh_salun/features/home/presentation/widgets/home/home_bottom_nav.dart';
import 'package:mh_salun/features/reservations/bloc/reservations_list/reservations_list_bloc.dart';
import 'package:mh_salun/features/reservations/presentation/reservations_tab_view.dart';
import 'package:mh_salun/features/services/bloc/services_bloc.dart';
import 'package:mh_salun/features/services/presentation/services_tab_view.dart';

/// Persistent shell owning the bottom nav bar and the in-place tab content.
/// Switching destinations only swaps the current [PageView] page — it
/// never pushes a new route.
///
/// The destination is not a constructor argument: it lives in [HomeTabCubit],
/// so screens outside the shell can select one before navigating here.
class HomeShellPage extends StatefulWidget {
  const HomeShellPage({super.key});

  @override
  State<HomeShellPage> createState() => _HomeShellPageState();
}

class _HomeShellPageState extends State<HomeShellPage> {
  late final PageController _pageController;
  late final OrganizationBloc _organizationBloc;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: context.read<HomeTabCubit>().state.index,
    );
    _organizationBloc = getIt<OrganizationBloc>()..add(OrganizationRequested());
    getIt<ProfileBloc>().add(ProfileRequested());
    _refreshUpcoming();
  }

  /// Reloads the upcoming list behind the home card and the upcoming tab. The
  /// refresh is silent once something has been listed, so neither blanks out.
  void _refreshUpcoming() =>
      context.read<UpcomingReservationsBloc>().add(ReservationsListRefreshed());

  @override
  void dispose() {
    _pageController.dispose();
    _organizationBloc.close();
    super.dispose();
  }

  void _onNavSelected(int index) => context.read<HomeTabCubit>().showAt(index);

  void _onTabChanged(BuildContext context, HomeTab tab) {
    _pageController.jumpToPage(tab.index);
    // The two destinations that show upcoming reservations — a booking may have
    // been made, or one may have passed, since they were last on screen.
    if (tab == HomeTab.home || tab == HomeTab.reservations) _refreshUpcoming();
  }

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
          BlocListener<HomeTabCubit, HomeTab>(listener: _onTabChanged),
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
            children: [
              const HomeTabView(),
              const ServicesTabView(),
              ReservationsTabView(onStartBooking: _onStartBooking),
              const AccountTabView(),
            ],
          ),
          bottomNavigationBar: BlocBuilder<HomeTabCubit, HomeTab>(
            builder: (context, tab) => HomeBottomNav(
              selectedIndex: tab.index,
              onDestinationSelected: _onNavSelected,
              onAddTap: _onAddTap,
            ),
          ),
        ),
      ),
    );
  }
}
