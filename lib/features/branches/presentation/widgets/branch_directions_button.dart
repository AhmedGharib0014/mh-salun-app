import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';
import 'package:mh_salun/features/branches/model/branch.dart';
import 'package:url_launcher/url_launcher.dart';

class BranchDirectionsButton extends StatelessWidget {
  const BranchDirectionsButton({super.key, required this.branch});

  final Branch branch;

  Future<void> _openMaps(BuildContext context) async {
    final launched = await launchUrl(
      branch.mapsUri,
      mode: LaunchMode.externalApplication,
    );
    if (!launched && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('branch_details_directions_error'.tr())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => _openMaps(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        ),
        textStyle: AppTextStyles.buttonPrimary,
      ),
      icon: const Icon(Icons.directions_outlined, size: AppSpacing.iconSm),
      label: Text('branch_details_directions_button'.tr()),
    );
  }
}
