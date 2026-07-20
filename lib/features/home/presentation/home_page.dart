import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mh_salun/core/router/app_router.dart';
import 'package:mh_salun/features/home/model/barber.dart';
import 'package:mh_salun/features/home/model/services_catalog.dart';
import 'package:mh_salun/features/home/presentation/widgets/home/barbers_section.dart';
import 'package:mh_salun/features/home/presentation/widgets/home/book_now_card.dart';
import 'package:mh_salun/features/home/presentation/widgets/home/greeting_header.dart';
import 'package:mh_salun/features/home/presentation/widgets/home/home_bottom_nav.dart';
import 'package:mh_salun/features/home/presentation/widgets/home/home_header.dart';
import 'package:mh_salun/features/home/presentation/widgets/home/services_section.dart';
import 'package:mh_salun/features/home/presentation/widgets/home/upcoming_booking_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const int _navIndex = 0;

  List<Barber> _buildBarbers() {
    return [
      Barber(
        initial: 'home_barber_1_name'.tr().substring(0, 1),
        name: 'home_barber_1_name'.tr(),
        rating: 'home_barber_1_rating'.tr(),
      ),
      Barber(
        initial: 'home_barber_2_name'.tr().substring(0, 1),
        name: 'home_barber_2_name'.tr(),
        rating: 'home_barber_2_rating'.tr(),
      ),
      Barber(
        initial: 'home_barber_3_name'.tr().substring(0, 1),
        name: 'home_barber_3_name'.tr(),
        rating: 'home_barber_3_rating'.tr(),
      ),
      Barber(
        initial: 'home_barber_4_name'.tr().substring(0, 1),
        name: 'home_barber_4_name'.tr(),
        rating: 'home_barber_4_rating'.tr(),
      ),
    ];
  }

  void _onProfileTap() {}

  void _onStartBooking() {}

  void _onSeeAllUpcoming() {}

  void _onSeeAllServices() {
    context.goNamed(AppRoutes.services);
  }

  void _onNavSelected(int index) {
    if (index == 1) context.goNamed(AppRoutes.services);
    // Bookings and account tabs have no screens yet.
  }

  void _onAddTap() {}

  @override
  Widget build(BuildContext context) {
    final services = ServicesCatalog.all();
    final barbers = _buildBarbers();

    return Scaffold(
      extendBody: true,
      body: SafeArea(
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
                onSeeAllTap: _onSeeAllServices,
              ),
              // Clearance so the last content clears the curved nav bar
              // (bar + raised circle + device bottom inset).
              SizedBox(
                height: HomeBottomNav.scrollClearance +
                    MediaQuery.of(context).padding.bottom,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: HomeBottomNav(
        selectedIndex: _navIndex,
        onDestinationSelected: _onNavSelected,
        onAddTap: _onAddTap,
      ),
    );
  }
}
