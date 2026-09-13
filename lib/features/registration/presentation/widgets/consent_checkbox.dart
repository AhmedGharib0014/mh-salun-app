import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/network/api_config.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

/// Checkbox gating registration on accepting the Terms of Service and
/// Privacy Policy. Participates in the enclosing [Form]'s validation, so
/// submitting without checking it surfaces an error like any other field.
class ConsentCheckbox extends FormField<bool> {
  ConsentCheckbox({super.key})
      : super(
          initialValue: false,
          validator: (accepted) =>
              accepted == true ? null : 'register_consent_required'.tr(),
          builder: (state) {
            void setChecked(bool checked) => state.didChange(checked);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: state.value ?? false,
                      onChanged: (checked) => setChecked(checked ?? false),
                      activeColor: AppColors.primary,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: AppSpacing.md),
                        child: GestureDetector(
                          onTap: () => setChecked(!(state.value ?? false)),
                          child: Text.rich(
                            TextSpan(
                              style: AppTextStyles.bodyRegular,
                              children: [
                                TextSpan(text: 'register_consent_prefix'.tr()),
                                TextSpan(
                                  text: 'register_consent_link'.tr(),
                                  style: AppTextStyles.bodyRegular.copyWith(
                                    color: AppColors.primary,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = _openPrivacyPolicy,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.only(left: AppSpacing.md),
                    child: Text(
                      state.errorText!,
                      style: AppTextStyles.caption
                          .copyWith(color: AppColors.error),
                    ),
                  ),
              ],
            );
          },
        );

  static Future<void> _openPrivacyPolicy() async {
    final uri = Uri.parse('${ApiConfig.baseUrl}/auth/privacy-policy');
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
