/// The steps of the new-reservation flow, in the order they are shown. A step's
/// selection is invalidated whenever an earlier one changes — see
/// `ReservationFlowBloc`.
enum ReservationStep {
  branch('new_reservation_to_barber'),
  barber('new_reservation_to_services'),
  services('new_reservation_to_datetime'),
  dateTime('new_reservation_to_review'),
  review('new_reservation_book');

  const ReservationStep(this.continueLabelKey);

  /// Localization key for the primary button while this step is on screen: it
  /// names what the *next* step selects, and on [review] it books.
  final String continueLabelKey;

  /// The step after this one, or null on the last one (where continuing books
  /// the reservation instead of advancing).
  ReservationStep? get next =>
      isLast ? null : ReservationStep.values[index + 1];

  /// The step before this one, or null on the first one (where going back
  /// leaves the flow).
  ReservationStep? get previous =>
      index == 0 ? null : ReservationStep.values[index - 1];

  bool get isLast => index == ReservationStep.values.length - 1;
}
