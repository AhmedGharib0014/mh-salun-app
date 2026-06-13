import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../network/dio_client.dart';

/// Provides third-party types to the DI container.
///
/// Types we don't own (and therefore can't annotate with `@injectable`) are
/// registered here via property/method accessors.
@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => createDioClient();
}
