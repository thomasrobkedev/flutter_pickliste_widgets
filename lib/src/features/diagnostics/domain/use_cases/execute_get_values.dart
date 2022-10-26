import '../../data/repository.dart';
import '../../presentation/bloc/bloc.dart';
import '../../presentation/bloc/event.dart';
import '../models/item.dart';

class PicklisteDiagnosticsUseCaseExecuteGetValues {
  final _repository = PicklisteDiagnosticsRepository();

  Future<void> call(PicklisteDiagnosticsBloc bloc) async {
    final items = await _repository.fetchAll();

    for (var item in items.props) {
      if (item.getValue != null) {
        _execute(bloc, item, item.getValue!);
      }
    }
  }

  Future<void> _execute(PicklisteDiagnosticsBloc bloc, PicklisteDiagnosticsItem item, Future<String?> Function() getValue) async {
    await _repository.updateItem(item, state: PicklisteDiagnosticsItemState.pending, value: '');

    try {
      final value = await getValue().timeout(const Duration(seconds: 10));
      bloc.add(PicklisteDiagnosticsItemUpdated(item, PicklisteDiagnosticsItemState.success, value.toString()));
    } catch (e) {
      bloc.add(PicklisteDiagnosticsItemUpdated(item, PicklisteDiagnosticsItemState.fail, e.toString()));
    }
  }
}
