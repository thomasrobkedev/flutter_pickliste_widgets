import '../../data/repository.dart';
import '../../presentation/bloc/bloc.dart';
import '../models/item.dart';

class PicklisteDiagnosticsUseCaseGetValues {
  final PicklisteDiagnosticsBloc bloc;

  PicklisteDiagnosticsUseCaseGetValues(this.bloc);

  void call() {
    final items = PicklisteDiagnosticsRepository().fetchAll();

    for (var item in items.props) {
      if (item.getValue != null) {
        _getValue(item, item.getValue!);
      }
    }
  }

  Future<void> _getValue(PicklisteDiagnosticsItem item, Future<String?> Function() getValue) async {
    try {
      final value = await getValue().timeout(const Duration(seconds: 10));
      bloc.add(PicklisteDiagnosticsItemUpdated(item, PicklisteDiagnosticsItemState.success, value.toString()));
    } catch (e) {
      bloc.add(PicklisteDiagnosticsItemUpdated(item, PicklisteDiagnosticsItemState.fail, e.toString()));
    }
  }
}
