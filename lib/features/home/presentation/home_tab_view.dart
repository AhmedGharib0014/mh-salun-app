import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mh_salun/core/router/app_router.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/presentation/widgets/section_loading.dart';
import 'package:mh_salun/features/branches/presentation/widgets/branches_section.dart';
import 'package:mh_salun/features/employees/presentation/widgets/employees/employees_section.dart';
import 'package:mh_salun/features/home/bloc/home_tab/home_tab_cubit.dart';
import 'package:mh_salun/features/home/bloc/organization/organization_bloc.dart';
import 'package:mh_salun/features/home/presentation/widgets/home/home_header.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/home_related/book_now_card.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/home_related/upcoming_booking_card.dart';

class HomeTabView extends StatelessWidget {
  const HomeTabView({super.key});

  void _onStartBooking(BuildContext context) =>
      context.pushNamed(AppRoutes.newReservation);

  void _onSeeAllUpcoming(BuildContext context) =>
      context.read<HomeTabCubit>().show(HomeTab.reservations);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const HomeHeader(),
            BookNowCard(onStartBooking: () => _onStartBooking(context)),
            UpcomingBookingCard(onSeeAllTap: () => _onSeeAllUpcoming(context)),
            // Every section below depends on the organization, so they share
            // a single spinner instead of one per section.
            BlocBuilder<OrganizationBloc, OrganizationState>(
              builder: (context, state) => state is OrganizationLoaded
                  ? const Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [BranchesSection(), EmployeesSection()],
                    )
                  : const SectionLoading(height: 290),
            ),
            // Clearance so the last content clears the curved nav bar
            // (bar + raised circle + device bottom inset).
            SizedBox(height: AppSpacing.bottomNavClearance),
          ],
        ),
      ),
    );
  }
}
