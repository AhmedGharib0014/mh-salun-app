import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mh_salun/core/router/app_router.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/presentation/widgets/section_loading.dart';
import 'package:mh_salun/features/employees/presentation/widgets/employees/employees_section.dart';
import 'package:mh_salun/features/home/bloc/organization_bloc.dart';
import 'package:mh_salun/features/home/presentation/widgets/home/book_now_card.dart';
import 'package:mh_salun/features/home/presentation/widgets/home/greeting_header.dart';
import 'package:mh_salun/features/home/presentation/widgets/home/home_header.dart';
import 'package:mh_salun/features/home/presentation/widgets/home/services_section.dart';
import 'package:mh_salun/features/home/presentation/widgets/home/upcoming_booking_card.dart';

class HomeTabView extends StatefulWidget {
  const HomeTabView({super.key, required this.onSeeAllServices});

  final VoidCallback onSeeAllServices;

  @override
  State<HomeTabView> createState() => _HomeTabViewState();
}

class _HomeTabViewState extends State<HomeTabView> {
  void _onStartBooking() => context.pushNamed(AppRoutes.newReservation);

  void _onSeeAllUpcoming() {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const HomeHeader(),
            const GreetingHeader(),
            BookNowCard(onStartBooking: _onStartBooking),
            UpcomingBookingCard(onSeeAllTap: _onSeeAllUpcoming),
            BlocBuilder<OrganizationBloc, OrganizationState>(
              builder: (context, state) => state is OrganizationLoaded
                  ? const EmployeesSection()
                  : const SectionLoading(height: 140),
            ),
            BlocBuilder<OrganizationBloc, OrganizationState>(
              builder: (context, state) => state is OrganizationLoaded
                  ? ServicesSection(onSeeAllTap: widget.onSeeAllServices)
                  : const SectionLoading(height: 220),
            ),
            // Clearance so the last content clears the curved nav bar
            // (bar + raised circle + device bottom inset).
            SizedBox(
              height: AppSpacing.bottomNavClearance +
                  MediaQuery.of(context).padding.bottom,
            ),
          ],
        ),
      ),
    );
  }
}
