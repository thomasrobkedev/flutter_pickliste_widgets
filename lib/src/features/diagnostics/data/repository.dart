import '../domain/models/item.dart';
import '../domain/models/items.dart';

class PicklisteDiagnosticsRepository {
  late PicklisteDiagnosticsItems _items;

  static final PicklisteDiagnosticsRepository _instance = PicklisteDiagnosticsRepository._internal();
  PicklisteDiagnosticsRepository._internal();
  factory PicklisteDiagnosticsRepository() => _instance;

  Future<void> setItems(PicklisteDiagnosticsItems items) async => _items = items;

  Future<PicklisteDiagnosticsItems> fetchAll() async => _items;

  Future<void> updateItem(PicklisteDiagnosticsItem item, {PicklisteDiagnosticsItemState? state, String? value}) async {
    item.state = state ?? item.state;
    item.value = value ?? item.value;
  }
}
