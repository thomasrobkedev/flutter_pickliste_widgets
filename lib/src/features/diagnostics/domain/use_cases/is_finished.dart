import '../../data/repository.dart';

class PicklisteDiagnosticsUseCaseIsFinished {
  final PicklisteDiagnosticsRepository _repository;

  PicklisteDiagnosticsUseCaseIsFinished(this._repository);

  bool call() {
    return _repository.fetchAll().isFinished;
  }
}
