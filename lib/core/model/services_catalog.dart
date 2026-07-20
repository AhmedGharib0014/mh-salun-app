import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/model/service.dart';

/// Placeholder catalog shared by the home and services screens until the
/// data layer provides real services.
abstract final class ServicesCatalog {
  static List<Service> all() {
    return [
      Service(
        icon: Icons.content_cut,
        name: 'home_service_classic_name'.tr(),
        description: 'home_service_classic_desc'.tr(),
        duration: 'home_service_classic_duration'.tr(),
        price: 'home_service_classic_price'.tr(),
      ),
      Service(
        icon: Icons.face_retouching_natural,
        name: 'home_service_beard_name'.tr(),
        description: 'home_service_beard_desc'.tr(),
        duration: 'home_service_beard_duration'.tr(),
        price: 'home_service_beard_price'.tr(),
      ),
      Service(
        icon: Icons.whatshot_outlined,
        name: 'home_service_hottowel_name'.tr(),
        description: 'home_service_hottowel_desc'.tr(),
        duration: 'home_service_hottowel_duration'.tr(),
        price: 'home_service_hottowel_price'.tr(),
      ),
      Service(
        icon: Icons.auto_fix_high,
        name: 'home_service_fade_name'.tr(),
        description: 'home_service_fade_desc'.tr(),
        duration: 'home_service_fade_duration'.tr(),
        price: 'home_service_fade_price'.tr(),
      ),
      Service(
        icon: Icons.child_care,
        name: 'home_service_kids_name'.tr(),
        description: 'home_service_kids_desc'.tr(),
        duration: 'home_service_kids_duration'.tr(),
        price: 'home_service_kids_price'.tr(),
      ),
      Service(
        icon: Icons.workspace_premium_outlined,
        name: 'home_service_full_name'.tr(),
        description: 'home_service_full_desc'.tr(),
        duration: 'home_service_full_duration'.tr(),
        price: 'home_service_full_price'.tr(),
      ),
    ];
  }
}
