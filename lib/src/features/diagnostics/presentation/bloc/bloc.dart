import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/models/item.dart';
import '../../domain/models/items.dart';
import '../../domain/use_cases.dart';

part 'events.dart';
part 'state.dart';

class PicklisteDiagnosticsBloc extends Bloc<PicklisteDiagnosticsEvent, PicklisteDiagnosticsState> {
  late final PicklisteDiagnosticsUseCases _useCases;

  PicklisteDiagnosticsBloc() : super(PicklisteDiagnosticsState()) {
    on<PicklisteDiagnosticsInitialized>(_onPicklisteDiagnosticsInitialized);
    on<PicklisteDiagnosticsItemUpdated>(_onPicklisteDiagnosticsItemUpdated);

    _initialize();
  }

  void _initialize() async {
    _useCases = PicklisteDiagnosticsUseCases(this);
    add(PicklisteDiagnosticsInitialized());
  }

  Future<void> _onPicklisteDiagnosticsInitialized(PicklisteDiagnosticsInitialized event, Emitter<PicklisteDiagnosticsState> emit) async {
    emit(
      state.copyWith(
        status: _Status.initialized,
        items: _useCases.getItems(),
        houseNumberURL: await _useCases.getHouseNumberURL(withPic: true),
      ),
    );

    _useCases.setItemsSync();
    _useCases.setItemsAsync();
  }

  Future<void> _onPicklisteDiagnosticsItemUpdated(PicklisteDiagnosticsItemUpdated event, Emitter<PicklisteDiagnosticsState> emit) async {
    _useCases.updateItem(event.item, event.state, event.value);

    emit(
      state.copyWith(
        items: _useCases.getItems(),
        status: _useCases.isFinished ? _Status.finished : null,
      ),
    );
  }
}
