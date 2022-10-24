import '../../data/repository.dart';
import '../models/items.dart';

class PicklisteDiagnosticsUseCaseGetItems {
  final PicklisteDiagnosticsRepository _repository;

  PicklisteDiagnosticsUseCaseGetItems(this._repository);

  Future<PicklisteDiagnosticsItems> call() async {
    return await _repository.fetchAll();
  }
}
