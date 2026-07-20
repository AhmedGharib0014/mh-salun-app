import 'package:flutter/material.dart';
import 'package:mh_salun/features/home/presentation/widgets/home/tab_placeholder_view.dart';

class AccountTabView extends StatelessWidget {
  const AccountTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabPlaceholderView(
      icon: Icons.person_outline,
      titleKey: 'home_nav_account',
    );
  }
}
