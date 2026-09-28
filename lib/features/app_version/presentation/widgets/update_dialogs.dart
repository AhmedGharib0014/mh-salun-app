import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:url_launcher/url_launcher.dart';

/// Opens the store page for [storeUrl] outside the app (Google Play / App
/// Store). Shows a snackbar if the link can't be opened so the user knows to
/// update manually.
Future<void> _openStore(BuildContext context, String storeUrl) async {
  final uri = Uri.tryParse(storeUrl);
  final launched = uri != null &&
      await launchUrl(uri, mode: LaunchMode.externalApplication);
  if (!launched && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('update_launch_error'.tr())),
    );
  }
}

/// Optional update: the user may update now or continue with the current
/// build. The returned future completes once the dialog is dismissed (either
/// choice) so the caller can resume start-up.
Future<void> showSoftUpdateDialog(
  BuildContext context, {
  required String storeUrl,
  required String latestVersion,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) => AlertDialog(
      title: Text('update_soft_title'.tr()),
      content: Text('update_soft_message'.tr(args: [latestVersion])),
      actions: [
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.primary),
                ),
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: Text('update_later_button'.tr()),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.onPrimary,
                ),
                onPressed: () async {
                  await _openStore(dialogContext, storeUrl);
                  if (dialogContext.mounted) Navigator.of(dialogContext).pop();
                },
                child: Text('update_now_button'.tr()),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

/// Forced update: the running build is below the minimum supported version.
/// The dialog can't be dismissed and offers no way to continue — the only
/// action sends the user to the store.
Future<void> showHardUpdateDialog(
  BuildContext context, {
  required String storeUrl,
  required String latestVersion,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) => PopScope(
      canPop: false,
      child: AlertDialog(
        title: Text('update_hard_title'.tr()),
        content: Text('update_hard_message'.tr(args: [latestVersion])),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.onPrimary,
            ),
            onPressed: () => _openStore(dialogContext, storeUrl),
            child: Text('update_now_button'.tr()),
          ),
        ],
      ),
    ),
  );
}
