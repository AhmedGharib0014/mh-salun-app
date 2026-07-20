import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/features/home/model/barber.dart';
import 'package:mh_salun/features/home/model/services_catalog.dart';
import 'package:mh_salun/features/home/presentation/widgets/home/barbers_section.dart';
import 'package:mh_salun/features/home/presentation/widgets/home/book_now_card.dart';
import 'package:mh_salun/features/home/presentation/widgets/home/greeting_header.dart';
import 'package:mh_salun/features/home/presentation/widgets/home/home_bottom_nav.dart';
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

  @override
  Widget build(BuildContext context) {
    final services = ServicesCatalog.all();
    final barbers = _buildBarbers();

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
              height: HomeBottomNav.scrollClearance +
                  MediaQuery.of(context).padding.bottom,
            ),
          ],
        ),
      ),
    );
  }
}
