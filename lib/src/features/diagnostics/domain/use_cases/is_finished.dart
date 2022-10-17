import '../../data/repository.dart';

class PicklisteDiagnosticsUseCaseIsFinished {
  bool call() {
    return PicklisteDiagnosticsRepository().fetchAll().isFinished;
  }
}
