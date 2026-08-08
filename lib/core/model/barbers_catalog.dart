import 'package:easy_localization/easy_localization.dart';
import 'package:mh_salun/core/model/barber.dart';

/// Placeholder roster shared by the home and reservation screens until the
/// data layer provides real barbers.
abstract final class BarbersCatalog {
  static List<Barber> all() {
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
}
