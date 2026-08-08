import 'package:easy_localization/easy_localization.dart';

enum ReservationStatus { confirmed, completed, cancelled }

class Reservation {
  const Reservation({
    required this.barberName,
    required this.services,
    required this.dateLabel,
    required this.timeLabel,
    required this.durationLabel,
    required this.status,
  });

  final String barberName;
  final String services;
  final String dateLabel;
  final String timeLabel;
  final String durationLabel;
  final ReservationStatus status;

  String get barberInitial =>
      barberName.isEmpty ? '' : barberName[0].toUpperCase();

  /// Placeholder data until the data layer provides real reservations.
  static List<Reservation> mockUpcoming() {
    return [
      Reservation(
        barberName: 'home_upcoming_barber_name'.tr(),
        services: 'home_upcoming_services'.tr(),
        dateLabel: 'home_today'.tr(),
        timeLabel: 'home_time_placeholder'.tr(),
        durationLabel: 'home_duration_60'.tr(),
        status: ReservationStatus.confirmed,
      ),
    ];
  }

  static List<Reservation> mockPrevious() {
    return [];
  }
}
