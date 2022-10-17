import '../../data/repository.dart';
import '../models/items.dart';

class PicklisteDiagnosticsUseCaseGetItems {
  PicklisteDiagnosticsItems call() {
    return PicklisteDiagnosticsRepository().fetchAll();
  }
}
