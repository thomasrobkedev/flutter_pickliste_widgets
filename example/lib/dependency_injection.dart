import 'package:flutter_pickliste_widgets/flutter_pickliste_widgets.dart';
import 'package:get_it/get_it.dart';

import 'app.dart';
import 'core/utils/translations.dart';
import 'features/diagnostics/domain/use_cases/get_house_number_url.dart';

class DependencyInjection {
  final di = GetIt.instance;

  void init() {
    /// Mehrfach-Ausführung bei den Integrationstests verhindern
    if (di.isRegistered<DependencyInjection>()) {
      return;
    } else {
      di.registerSingleton<DependencyInjection>(DependencyInjection());
    }

    // Übersetzungen initalisieren
    T().init(MyApp.scaffoldMessengerKey);

    // use cases
    di.registerSingleton<DiagnosticsUseCaseGetHouseNumberURL>(DiagnosticsUseCaseGetHouseNumberURL());

    // package use cases
    di.registerSingleton<PicklisteDiagnosticsUseCaseDateTime>(PicklisteDiagnosticsUseCaseDateTime());
    di.registerSingleton<PicklisteUseCaseHttp>(PicklisteUseCaseHttp());
  }
}
