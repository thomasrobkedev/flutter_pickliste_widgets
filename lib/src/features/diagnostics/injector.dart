import 'package:get_it/get_it.dart';

import 'data/repository.dart';
import 'domain/use_cases/get_items.dart';
import 'domain/use_cases/get_values.dart';
import 'domain/use_cases/is_finished.dart';
import 'domain/use_cases/save_items.dart';
import 'domain/use_cases/update_item.dart';
import 'presentation/bloc/bloc.dart';

final injector = GetIt.instance;

Future<void> initializePicklisteDianosticsDependencies() async {
  // Da diese Funktion bei jedem Start der Seite aufgerufen wird, müssen wir Mehrfach-Registrierungen verhinden.
  if (!injector.isRegistered<PicklisteDiagnosticsRepository>()) {
    // repository
    injector.registerSingleton<PicklisteDiagnosticsRepository>(PicklisteDiagnosticsRepository());

    // use cases
    injector.registerSingleton<PicklisteDiagnosticsUseCaseGetItems>(PicklisteDiagnosticsUseCaseGetItems(injector()));
    injector.registerSingleton<PicklisteDiagnosticsUseCaseSaveItems>(PicklisteDiagnosticsUseCaseSaveItems(injector()));
    injector.registerSingleton<PicklisteDiagnosticsUseCaseUpdateItem>(PicklisteDiagnosticsUseCaseUpdateItem(injector()));
    injector.registerSingleton<PicklisteDiagnosticsUseCaseGetValues>(PicklisteDiagnosticsUseCaseGetValues(injector()));
    injector.registerSingleton<PicklisteDiagnosticsUseCaseIsFinished>(PicklisteDiagnosticsUseCaseIsFinished(injector()));

    // bloc
    injector.registerFactory<PicklisteDiagnosticsBloc>(() => PicklisteDiagnosticsBloc(injector(), injector(), injector(), injector(), injector()));
  }
}
