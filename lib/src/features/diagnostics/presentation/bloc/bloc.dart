import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/models/item.dart';
import '../../domain/models/items.dart';
import '../../domain/use_cases/add_callbacks.dart';
import '../../domain/use_cases/get_items.dart';
import '../../domain/use_cases/is_finished.dart';
import '../../domain/use_cases/set_items.dart';
import '../../domain/use_cases/update_item.dart';

part 'events.dart';
part 'state.dart';

class PicklisteDiagnosticsBloc extends Bloc<PicklisteDiagnosticsEvent, PicklisteDiagnosticsState> {
  final PicklisteDiagnosticsItems items;
  final String houseNumberURL;

  PicklisteDiagnosticsBloc(this.items, this.houseNumberURL) : super(PicklisteDiagnosticsState()) {
    on<PicklisteDiagnosticsInitialized>(_onPicklisteDiagnosticsInitialized);
    on<PicklisteDiagnosticsItemUpdated>(_onPicklisteDiagnosticsItemUpdated);

    _initialize();
  }

  void _initialize() async {
    PicklisteDiagnosticsUseCaseSetItems().call(items);
    add(PicklisteDiagnosticsInitialized());
  }

  Future<void> _onPicklisteDiagnosticsInitialized(PicklisteDiagnosticsInitialized event, Emitter<PicklisteDiagnosticsState> emit) async {
    emit(
      state.copyWith(
        status: _Status.initialized,
        items: PicklisteDiagnosticsUseCaseGetItems().call(),
      ),
    );

    PicklisteDiagnosticsUseCaseAddCallbacks(this).call();
  }

  Future<void> _onPicklisteDiagnosticsItemUpdated(PicklisteDiagnosticsItemUpdated event, Emitter<PicklisteDiagnosticsState> emit) async {
    PicklisteDiagnosticsUseCaseUpdateItem().call(event.item, event.state, event.value);

    emit(
      state.copyWith(
        items: PicklisteDiagnosticsUseCaseGetItems().call(),
        status: PicklisteDiagnosticsUseCaseIsFinished().call() ? _Status.finished : null,
      ),
    );
  }
}
