import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mh_salun/core/model/barbers_catalog.dart';
import 'package:mh_salun/core/model/services_catalog.dart';
import 'package:mh_salun/core/router/app_router.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/features/home/presentation/widgets/home/barbers_section.dart';
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
  void _onProfileTap() {}

  void _onStartBooking() => context.pushNamed(AppRoutes.newReservation);

  void _onSeeAllUpcoming() {}

  @override
  Widget build(BuildContext context) {
    final services = ServicesCatalog.all();
    final barbers = BarbersCatalog.all();

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HomeHeader(onProfileTap: _onProfileTap),
            const GreetingHeader(),
            BookNowCard(onStartBooking: _onStartBooking),
            UpcomingBookingCard(onSeeAllTap: _onSeeAllUpcoming),
            BarbersSection(barbers: barbers),
            ServicesSection(
              services: services,
              onSeeAllTap: widget.onSeeAllServices,
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
