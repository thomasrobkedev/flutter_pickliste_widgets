import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/models/item.dart';
import '../../domain/models/items.dart';
import '../../domain/use_cases/get_items.dart';
import '../../domain/use_cases/get_values.dart';
import '../../domain/use_cases/is_finished.dart';
import '../../domain/use_cases/save_items.dart';
import '../../domain/use_cases/update_item.dart';

part 'events.dart';
part 'state.dart';

class PicklisteDiagnosticsBloc extends Bloc<PicklisteDiagnosticsEvent, PicklisteDiagnosticsState> {
  final PicklisteDiagnosticsUseCaseGetItems _getItems;
  final PicklisteDiagnosticsUseCaseSaveItems _saveItems;
  final PicklisteDiagnosticsUseCaseUpdateItem _updateItem;
  final PicklisteDiagnosticsUseCaseGetValues _getValues;
  final PicklisteDiagnosticsUseCaseIsFinished _isFinished;

  PicklisteDiagnosticsBloc(
    this._getItems,
    this._saveItems,
    this._updateItem,
    this._getValues,
    this._isFinished,
  ) : super(PicklisteDiagnosticsState()) {
    on<PicklisteDiagnosticsInitialized>(_onInitialized);
    on<PicklisteDiagnosticsItemUpdated>(_onItemUpdated);
  }

  Future<void> initialize(PicklisteDiagnosticsItems items) async {
    _saveItems(items);
    add(PicklisteDiagnosticsInitialized());
  }

  Future<void> _onInitialized(PicklisteDiagnosticsInitialized event, Emitter<PicklisteDiagnosticsState> emit) async {
    emit(
      state.copyWith(
        status: _Status.initialized,
        items: _getItems(),
      ),
    );
    _getValues(this);
  }

  Future<void> _onItemUpdated(PicklisteDiagnosticsItemUpdated event, Emitter<PicklisteDiagnosticsState> emit) async {
    _updateItem(event.item, event.state, event.value);
    emit(
      state.copyWith(
        items: _getItems(),
        status: _isFinished() ? _Status.finished : null,
      ),
    );
  }
}
