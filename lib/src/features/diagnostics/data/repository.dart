import '../domain/models/item.dart';
import '../domain/models/items.dart';

class PicklisteDiagnosticsRepository {
  late PicklisteDiagnosticsItems _items;

  void setItems(PicklisteDiagnosticsItems items) => _items = items;

  PicklisteDiagnosticsItems fetchAll() => _items;

  void updateItem(PicklisteDiagnosticsItem item, {PicklisteDiagnosticsItemState? state, String? value}) {
    item.state = state ?? item.state;
    item.value = value ?? item.value;
  }
}
