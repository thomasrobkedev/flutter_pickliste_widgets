import '../../data/repository.dart';
import '../../presentation/bloc/bloc.dart';
import '../models/item.dart';

class PicklisteDiagnosticsUseCaseGetValues {
  final PicklisteDiagnosticsRepository _repository;

  PicklisteDiagnosticsUseCaseGetValues(this._repository);

  void call(PicklisteDiagnosticsBloc bloc) {
    final items = _repository.fetchAll();

    for (var item in items.props) {
      if (item.getValue != null) {
        _getValue(bloc, item, item.getValue!);
      }
    }
  }

  Future<void> _getValue(PicklisteDiagnosticsBloc bloc, PicklisteDiagnosticsItem item, Future<String?> Function() getValue) async {
    try {
      final value = await getValue().timeout(const Duration(seconds: 10));
      bloc.add(PicklisteDiagnosticsItemUpdated(item, PicklisteDiagnosticsItemState.success, value.toString()));
    } catch (e) {
      bloc.add(PicklisteDiagnosticsItemUpdated(item, PicklisteDiagnosticsItemState.fail, e.toString()));
    }
  }
}
