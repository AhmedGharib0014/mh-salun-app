import 'package:flutter/material.dart';
import 'package:mh_salun/features/home/presentation/widgets/home/tab_placeholder_view.dart';

class BookingsTabView extends StatelessWidget {
  const BookingsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabPlaceholderView(
      icon: Icons.calendar_today_outlined,
      titleKey: 'home_nav_bookings',
    );
  }
}
