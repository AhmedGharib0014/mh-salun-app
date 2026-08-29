import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

/// The home shell's four bottom-nav destinations, in bar order.
enum HomeTab { home, services, reservations, account }

/// Owns which destination the home shell shows.
///
/// It is a singleton so screens outside the shell — the reservation success
/// page, the auth listener — can pick the destination before navigating to
/// `/home`, and the shell picks it up whether it is rebuilt or already alive.
@lazySingleton
class HomeTabCubit extends Cubit<HomeTab> {
  HomeTabCubit() : super(HomeTab.home);

  void show(HomeTab tab) => emit(tab);

  void showAt(int index) => emit(HomeTab.values[index]);
}
