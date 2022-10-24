import 'package:get_it/get_it.dart';

import 'app.dart';
import 'core/utils/environment.dart';
import 'core/utils/translations.dart';

class DependencyInjection {
  final di = GetIt.instance;

  void init() {
    if (di.isRegistered<DependencyInjection>()) {
      return;
    } else {
      di.registerSingleton<DependencyInjection>(DependencyInjection());
    }

    // Übersetzungen initalisieren
    T().init(MyApp.scaffoldMessengerKey);

    // Environment
    di.registerSingleton<Environment>(Environment());
  }
}
