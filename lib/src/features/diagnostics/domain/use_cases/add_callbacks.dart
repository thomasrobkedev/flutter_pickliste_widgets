import '../../data/repository.dart';
import '../../presentation/bloc/bloc.dart';
import '../models/item.dart';

class PicklisteDiagnosticsUseCaseAddCallbacks {
  final PicklisteDiagnosticsBloc bloc;

  PicklisteDiagnosticsUseCaseAddCallbacks(this.bloc);

  void call() {
    final items = PicklisteDiagnosticsRepository().fetchAll();

    for (var item in items.props) {
      _addCallback(item, item.getValue);
    }
  }

  Future<void> _addCallback(PicklisteDiagnosticsItem item, Future<String?> Function() getValue) async {
    PicklisteDiagnosticsRepository().updateItem(item, state: PicklisteDiagnosticsItemState.pending);

    try {
      final value = await getValue().timeout(const Duration(seconds: 10));
      bloc.add(PicklisteDiagnosticsItemUpdated(item, PicklisteDiagnosticsItemState.success, value.toString()));
    } catch (e) {
      bloc.add(PicklisteDiagnosticsItemUpdated(item, PicklisteDiagnosticsItemState.fail, e.toString()));
    }
  }
}
