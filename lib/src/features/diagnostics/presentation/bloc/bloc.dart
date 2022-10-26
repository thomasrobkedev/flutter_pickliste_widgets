import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_cases/execute_get_values.dart';
import '../../domain/use_cases/get_items.dart';
import '../../domain/use_cases/is_finished.dart';
import '../../domain/use_cases/save_items.dart';
import '../../domain/use_cases/update_item.dart';
import 'event.dart';
import 'state.dart';

class PicklisteDiagnosticsBloc extends Bloc<PicklisteDiagnosticsEvent, PicklisteDiagnosticsState> {
  final _getItems = PicklisteDiagnosticsUseCaseGetItems();
  final _saveItems = PicklisteDiagnosticsUseCaseSaveItems();
  final _updateItem = PicklisteDiagnosticsUseCaseUpdateItem();
  final _executeGetValues = PicklisteDiagnosticsUseCaseExecuteGetValues();
  final _isFinished = PicklisteDiagnosticsUseCaseIsFinished();

  PicklisteDiagnosticsBloc() : super(PicklisteDiagnosticsLoading()) {
    on<PicklisteDiagnosticsInitialize>(_onInitialize);
    on<PicklisteDiagnosticsItemUpdated>(_onItemUpdated);
  }

  Future<void> _onInitialize(PicklisteDiagnosticsInitialize event, Emitter<PicklisteDiagnosticsState> emit) async {
    await _saveItems(event.items);
    emit(PicklisteDiagnosticsPending(event.items));
    _executeGetValues(this);
  }

  Future<void> _onItemUpdated(PicklisteDiagnosticsItemUpdated event, Emitter<PicklisteDiagnosticsState> emit) async {
    await _updateItem(event.item, event.state, event.value);
    emit(
      await _isFinished() //
          ? PicklisteDiagnosticsFinished(await _getItems())
          : PicklisteDiagnosticsPending(await _getItems()),
    );
  }
}
