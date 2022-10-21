part of 'bloc.dart';

abstract class PicklisteDiagnosticsEvent {}

class PicklisteDiagnosticsInitialized extends PicklisteDiagnosticsEvent {}

class PicklisteDiagnosticsItemUpdated extends PicklisteDiagnosticsEvent {
  final PicklisteDiagnosticsItem item;
  final PicklisteDiagnosticsItemState state;
  final String value;
  PicklisteDiagnosticsItemUpdated(this.item, this.state, this.value);
}
