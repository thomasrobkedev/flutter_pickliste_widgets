import 'package:flutter_pickliste_widgets/flutter_pickliste_widgets.dart';
import 'package:get_it/get_it.dart';

import 'features/diagnostics/domain/use_cases/get_house_number_url.dart';
import 'features/diagnostics/domain/use_cases/get_items.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  // Pickliste, use cases
  injector.registerSingleton<PicklisteDiagnosticsUseCaseGetDateTime>(PicklisteDiagnosticsUseCaseGetDateTime());
  injector.registerSingleton<PicklisteDiagnosticsUseCaseGetHttp>(PicklisteDiagnosticsUseCaseGetHttp());

  // Diagnostics, use cases
  injector.registerSingleton<DiagnosticsUseCaseGetHouseNumberURL>(DiagnosticsUseCaseGetHouseNumberURL());
  injector.registerFactory<DiagnosticsUseCaseGetItems>(() => DiagnosticsUseCaseGetItems(injector(), injector(), injector()));
}
