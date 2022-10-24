import '../domain/models/item.dart';
import '../domain/models/items.dart';

class PicklisteDiagnosticsRepository {
  late PicklisteDiagnosticsItems _items;

  Future<void> setItems(PicklisteDiagnosticsItems items) async => _items = items;

  Future<PicklisteDiagnosticsItems> fetchAll() async => _items;

  Future<void> updateItem(PicklisteDiagnosticsItem item, {PicklisteDiagnosticsItemState? state, String? value}) async {
    item.state = state ?? item.state;
    item.value = value ?? item.value;
  }
}
