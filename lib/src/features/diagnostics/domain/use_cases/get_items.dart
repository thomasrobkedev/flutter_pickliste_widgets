import '../../data/repository.dart';
import '../models/items.dart';

class PicklisteDiagnosticsUseCaseGetItems {
  final PicklisteDiagnosticsRepository _repository;

  PicklisteDiagnosticsUseCaseGetItems(this._repository);

  PicklisteDiagnosticsItems call() {
    return _repository.fetchAll();
  }
}
