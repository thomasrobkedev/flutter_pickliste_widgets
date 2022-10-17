import '../../data/repository.dart';
import '../models/items.dart';

class PicklisteDiagnosticsUseCaseSetItems {
  void call(PicklisteDiagnosticsItems items) {
    PicklisteDiagnosticsRepository().setItems(items);
  }
}
