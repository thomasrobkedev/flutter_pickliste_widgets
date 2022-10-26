import '../../data/repository.dart';
import '../models/items.dart';

class PicklisteDiagnosticsUseCaseGetItems {
  final _repository = PicklisteDiagnosticsRepository();

  Future<PicklisteDiagnosticsItems> call() async {
    return await _repository.fetchAll();
  }
}
