import 'package:get_it/get_it.dart';

import '../flutter_pickliste_widgets.dart';
import 'features/diagnostics/domain/use_cases/execute_get_values.dart';
import 'features/diagnostics/domain/use_cases/get_items.dart';
import 'features/diagnostics/domain/use_cases/is_finished.dart';
import 'features/diagnostics/domain/use_cases/save_items.dart';
import 'features/diagnostics/domain/use_cases/update_item.dart';
import 'features/diagnostics/presentation/bloc/bloc.dart';

class PicklisteDependencyInjection {
  final di = GetIt.instance;

  void init() {
    if (di.isRegistered<PicklisteDependencyInjection>()) {
      return;
    } else {
      di.registerSingleton<PicklisteDependencyInjection>(PicklisteDependencyInjection());
    }

    // repository
    di.registerSingleton<PicklisteDiagnosticsRepository>(PicklisteDiagnosticsRepository());

    // use cases
    di.registerSingleton<PicklisteDiagnosticsUseCaseGetItems>(PicklisteDiagnosticsUseCaseGetItems(di()));
    di.registerSingleton<PicklisteDiagnosticsUseCaseSaveItems>(PicklisteDiagnosticsUseCaseSaveItems(di()));
    di.registerSingleton<PicklisteDiagnosticsUseCaseUpdateItem>(PicklisteDiagnosticsUseCaseUpdateItem(di()));
    di.registerSingleton<PicklisteDiagnosticsUseCaseExecuteGetValues>(PicklisteDiagnosticsUseCaseExecuteGetValues(di()));
    di.registerSingleton<PicklisteDiagnosticsUseCaseIsFinished>(PicklisteDiagnosticsUseCaseIsFinished(di()));

    // bloc
    di.registerFactory<PicklisteDiagnosticsBloc>(() => PicklisteDiagnosticsBloc(di(), di(), di(), di(), di()));
  }
}
