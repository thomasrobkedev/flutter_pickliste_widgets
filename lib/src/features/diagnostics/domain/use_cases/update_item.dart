import '../../data/repository.dart';
import '../models/item.dart';

class PicklisteDiagnosticsUseCaseUpdateItem {
  final PicklisteDiagnosticsRepository _repository;

  PicklisteDiagnosticsUseCaseUpdateItem(this._repository);

  void call(PicklisteDiagnosticsItem item, PicklisteDiagnosticsItemState state, String value) {
    _repository.updateItem(item, state: state, value: value);
  }
}
