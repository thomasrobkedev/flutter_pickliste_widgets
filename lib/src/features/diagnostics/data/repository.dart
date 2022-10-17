import '../domain/models/item.dart';
import '../domain/models/items.dart';

class PicklisteDiagnosticsRepository {
  static PicklisteDiagnosticsRepository _instance = PicklisteDiagnosticsRepository._internal();
  factory PicklisteDiagnosticsRepository() => _instance;
  PicklisteDiagnosticsRepository._internal() {
    _instance = this;
  }

  late PicklisteDiagnosticsItems _items;

  void setItems(PicklisteDiagnosticsItems items) => _items = items;

  PicklisteDiagnosticsItems fetchAll() => _items;

  void updateItem(PicklisteDiagnosticsItem item, {PicklisteDiagnosticsItemState? state, String? value}) {
    item.state = state ?? item.state;
    item.value = value ?? item.value;
  }
}
