import '../../data/repository.dart';
import '../models/items.dart';

class PicklisteDiagnosticsUseCaseSaveItems {
  final PicklisteDiagnosticsRepository _repository;

  PicklisteDiagnosticsUseCaseSaveItems(this._repository);

  Future<void> call(PicklisteDiagnosticsItems items) async {
    await _repository.setItems(items);
  }
}
