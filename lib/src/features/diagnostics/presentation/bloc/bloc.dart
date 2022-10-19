import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/models/item.dart';
import '../../domain/models/items.dart';
import '../../domain/use_cases/get_items.dart';
import '../../domain/use_cases/get_values.dart';
import '../../domain/use_cases/is_finished.dart';
import '../../domain/use_cases/set_items.dart';
import '../../domain/use_cases/update_item.dart';

part 'events.dart';
part 'state.dart';

class PicklisteDiagnosticsBloc extends Bloc<PicklisteDiagnosticsEvent, PicklisteDiagnosticsState> {
  final PicklisteDiagnosticsItems Function() getItems;
  final String houseNumberURL;

  // use cases (TODO: via injector rein reichen)
  final _getItems = PicklisteDiagnosticsUseCaseGetItems();
  final _setItems = PicklisteDiagnosticsUseCaseSetItems();
  final _updateItem = PicklisteDiagnosticsUseCaseUpdateItem();
  final _isFinished = PicklisteDiagnosticsUseCaseIsFinished();
  late final PicklisteDiagnosticsUseCaseGetValues _getValues;

  PicklisteDiagnosticsBloc(this.getItems, this.houseNumberURL) : super(PicklisteDiagnosticsState()) {
    on<PicklisteDiagnosticsInitialized>(_onPicklisteDiagnosticsInitialized);
    on<PicklisteDiagnosticsItemUpdated>(_onPicklisteDiagnosticsItemUpdated);

    _getValues = PicklisteDiagnosticsUseCaseGetValues(this);
    _initialize();
  }

  void _initialize() async {
    _setItems(getItems());
    add(PicklisteDiagnosticsInitialized());
  }

  Future<void> _onPicklisteDiagnosticsInitialized(PicklisteDiagnosticsInitialized event, Emitter<PicklisteDiagnosticsState> emit) async {
    emit(
      state.copyWith(
        status: _Status.initialized,
        items: _getItems(),
      ),
    );
    _getValues();
  }

  Future<void> _onPicklisteDiagnosticsItemUpdated(PicklisteDiagnosticsItemUpdated event, Emitter<PicklisteDiagnosticsState> emit) async {
    _updateItem(event.item, event.state, event.value);
    emit(
      state.copyWith(
        items: _getItems(),
        status: _isFinished() ? _Status.finished : null,
      ),
    );
  }
}
