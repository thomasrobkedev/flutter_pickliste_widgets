import '../../data/repository.dart';
import '../models/items.dart';

class PicklisteDiagnosticsUseCaseSaveItems {
  final PicklisteDiagnosticsRepository _repository;

  PicklisteDiagnosticsUseCaseSaveItems(this._repository);

  void call(PicklisteDiagnosticsItems items) {
    _repository.setItems(items);
  }
}
