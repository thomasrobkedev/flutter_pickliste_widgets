import '../../data/repository.dart';
import '../models/items.dart';

class PicklisteDiagnosticsUseCaseSaveItems {
  final _repository = PicklisteDiagnosticsRepository();

  Future<void> call(PicklisteDiagnosticsItems items) async {
    await _repository.setItems(items);
  }
}
