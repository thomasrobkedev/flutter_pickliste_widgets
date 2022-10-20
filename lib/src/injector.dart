import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'features/diagnostics/data/repository.dart';
import 'features/diagnostics/domain/use_cases/get_date_time.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio client
  injector.registerSingleton<Dio>(Dio());

  // Diagnostics, repository
  injector.registerSingleton<PicklisteDiagnosticsRepository>(
    PicklisteDiagnosticsRepository(),
  );

  // Diagnostics, use cases
  injector.registerSingleton<PicklisteDiagnosticsUseCaseGetDateTime>(PicklisteDiagnosticsUseCaseGetDateTime());

  // Diagnostics, bloc
}
