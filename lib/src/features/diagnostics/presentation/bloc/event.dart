import '../../domain/models/item.dart';
import '../../domain/models/items.dart';

abstract class PicklisteDiagnosticsEvent {}

class PicklisteDiagnosticsInitialize extends PicklisteDiagnosticsEvent {
  final PicklisteDiagnosticsItems items;

  PicklisteDiagnosticsInitialize(this.items);
}

class PicklisteDiagnosticsItemUpdated extends PicklisteDiagnosticsEvent {
  final PicklisteDiagnosticsItem item;
  final PicklisteDiagnosticsItemState state;
  final String value;

  PicklisteDiagnosticsItemUpdated(this.item, this.state, this.value);
}
