import '../../data/repository.dart';
import '../models/item.dart';

class PicklisteDiagnosticsUseCaseUpdateItem {
  void call(PicklisteDiagnosticsItem item, PicklisteDiagnosticsItemState state, String value) {
    PicklisteDiagnosticsRepository().updateItem(item, state: state, value: value);
  }
}
