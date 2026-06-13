import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

/// The single shared service locator for the app.
final getIt = GetIt.instance;

/// Wires up every `@injectable` class and `@module` provider.
///
/// Call once in `main()` before `runApp`. The implementation lives in the
/// generated `injection.config.dart` (run codegen after adding new
/// injectables — see CLAUDE.md).
@InjectableInit()
void configureDependencies() => getIt.init();
