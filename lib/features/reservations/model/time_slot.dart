/// A single bookable time on a given day. [available] is false when the slot
/// is already taken or lies in the past. [duration] is how long the slot runs,
/// so the UI can show a "start – end" range.
class TimeSlot {
  const TimeSlot({
    required this.time,
    required this.available,
    this.duration = const Duration(minutes: 30),
  });

  final DateTime time;
  final bool available;
  final Duration duration;

  /// The moment this slot ends.
  DateTime get end => time.add(duration);

  /// Placeholder day schedule until the data layer provides real slots.
  /// Runs 10:00–19:30 in 30-minute steps; slots already past (for today) and
  /// a deterministic handful of "taken" ones are marked unavailable.
  static List<TimeSlot> forDate(DateTime date) {
    const step = Duration(minutes: 30);
    final now = DateTime.now();
    final day = DateTime(date.year, date.month, date.day);

    return List.generate(20, (index) {
      final minutes = 10 * 60 + index * 30; // from 10:00
      final time = day.add(Duration(minutes: minutes));
      final isPast = time.isBefore(now);
      // Stable pseudo-random "already booked" pattern per day.
      final isTaken = (day.day + index) % 4 == 0;
      return TimeSlot(time: time, available: !isPast && !isTaken, duration: step);
    });
  }
}
