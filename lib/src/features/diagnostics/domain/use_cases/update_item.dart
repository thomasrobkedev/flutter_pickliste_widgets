import '../../data/repository.dart';
import '../models/item.dart';

class PicklisteDiagnosticsUseCaseUpdateItem {
  final _repository = PicklisteDiagnosticsRepository();

  Future<void> call(PicklisteDiagnosticsItem item, PicklisteDiagnosticsItemState state, String value) async {
    await _repository.updateItem(item, state: state, value: value);
  }
}
