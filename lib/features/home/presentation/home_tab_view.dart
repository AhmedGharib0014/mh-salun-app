import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mh_salun/core/di/injection.dart';
import 'package:mh_salun/core/model/barbers_catalog.dart';
import 'package:mh_salun/core/model/services_catalog.dart';
import 'package:mh_salun/core/router/app_router.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/features/home/bloc/organization_bloc.dart';
import 'package:mh_salun/features/home/presentation/widgets/home/barbers_section.dart';
import 'package:mh_salun/features/home/presentation/widgets/home/section_loading.dart';
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
  late final OrganizationBloc _organizationBloc;

  @override
  void initState() {
    super.initState();
    _organizationBloc = getIt<OrganizationBloc>()
      ..add(OrganizationRequested());
  }

  @override
  void dispose() {
    _organizationBloc.close();
    super.dispose();
  }

  void _onStartBooking() => context.pushNamed(AppRoutes.newReservation);

  void _onSeeAllUpcoming() {}

  @override
  Widget build(BuildContext context) {
    final services = ServicesCatalog.all();
    final barbers = BarbersCatalog.all();

    return BlocProvider.value(
      value: _organizationBloc,
      child: SafeArea(
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
                builder: (context, state) => state is OrganizationLoaded ||
                        state is OrganizationFailure
                    ? BarbersSection(barbers: barbers)
                    : const SectionLoading(height: 140),
              ),
              BlocBuilder<OrganizationBloc, OrganizationState>(
                builder: (context, state) => state is OrganizationLoaded ||
                        state is OrganizationFailure
                    ? ServicesSection(
                        services: services,
                        onSeeAllTap: widget.onSeeAllServices,
                      )
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
      ),
    );
  }
}
