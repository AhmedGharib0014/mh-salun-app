import 'package:flutter/material.dart';
import 'package:mh_salun/features/home/presentation/home_tab_view.dart';
import 'package:mh_salun/features/home/presentation/services_tab_view.dart';
import 'package:mh_salun/features/home/presentation/widgets/home/home_bottom_nav.dart';

/// Persistent shell owning the bottom nav bar and the in-place tab content.
/// Switching between the Home and Services destinations only swaps the
/// current [PageView] page — it never pushes a new route.
class HomeShellPage extends StatefulWidget {
  const HomeShellPage({super.key});

  @override
  State<HomeShellPage> createState() => _HomeShellPageState();
}

class _HomeShellPageState extends State<HomeShellPage> {
  final _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToTab(int index) {
    setState(() => _currentIndex = index);
    _pageController.jumpToPage(index);
  }

  void _onNavSelected(int index) {
    if (index == 0 || index == 1) _goToTab(index);
    // Bookings and account tabs have no screens yet.
  }

  void _onSeeAllServices() => _goToTab(1);

  void _onAddTap() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) => setState(() => _currentIndex = index),
        children: [
          HomeTabView(onSeeAllServices: _onSeeAllServices),
          const ServicesTabView(),
        ],
      ),
      bottomNavigationBar: HomeBottomNav(
        selectedIndex: _currentIndex,
        onDestinationSelected: _onNavSelected,
        onAddTap: _onAddTap,
      ),
    );
  }
}
