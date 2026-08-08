import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/app_colors.dart';

/// Centered spinner shown in place of a home section while it waits on
/// data that depends on the organization (e.g. barbers, services).
class SectionLoading extends StatelessWidget {
  const SectionLoading({super.key, required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      ),
    );
  }
}
