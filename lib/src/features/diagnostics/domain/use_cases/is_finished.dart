import '../../data/repository.dart';
import '../models/item.dart';

class PicklisteDiagnosticsUseCaseIsFinished {
  final PicklisteDiagnosticsRepository _repository;

  PicklisteDiagnosticsUseCaseIsFinished(this._repository);

  Future<bool> call() async {
    final items = await _repository.fetchAll();

    return items.props //
        .where((item) => item.getValue != null)
        .every((item) => item.state != PicklisteDiagnosticsItemState.pending);
  }
}
