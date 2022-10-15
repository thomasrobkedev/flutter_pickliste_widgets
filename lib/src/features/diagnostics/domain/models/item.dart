enum PicklisteDiagnosticsItemState { none, success, fail, pending }

class PicklisteDiagnosticsItem {
  final String keyname;
  PicklisteDiagnosticsItemState state = PicklisteDiagnosticsItemState.none;
  String value = '';

  PicklisteDiagnosticsItem(this.keyname);

  String get testKexPrefix => 'settings_diagnostics_item_$keyname';
  String get testKeyState => state.toString().split('.')[1];
}
