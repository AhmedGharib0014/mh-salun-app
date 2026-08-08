import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/model/barber.dart';
import 'package:mh_salun/features/home/presentation/widgets/home/barber_avatar.dart';
import 'package:mh_salun/features/home/presentation/widgets/home/section_header.dart';

class BarbersSection extends StatelessWidget {
  const BarbersSection({super.key, required this.barbers});

  final List<Barber> barbers;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SectionHeader(titleKey: 'home_barbers_title'),
        SizedBox(
          height: 140,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            itemCount: barbers.length,
            separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.md),
            itemBuilder: (context, index) =>
                BarberAvatar(barber: barbers[index]),
          ),
        ),
      ],
    );
  }
}
