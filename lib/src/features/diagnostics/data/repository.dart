import '../domain/models/item.dart';
import '../domain/models/items.dart';

class PicklisteDiagnosticsRepository {
  final _items = PicklisteDiagnosticsItems();

  PicklisteDiagnosticsItems fetchAll() {
    return _items;
  }

  void updateItem(PicklisteDiagnosticsItem item, {PicklisteDiagnosticsItemState? state, String? value}) {
    item.state = state ?? item.state;
    item.value = value ?? item.value;
  }
}
