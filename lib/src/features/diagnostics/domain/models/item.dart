enum PicklisteDiagnosticsItemState { none, success, fail, pending }

class PicklisteDiagnosticsItem {
  final String keyname;
  late final Future<String?> Function() getValue;
  PicklisteDiagnosticsItemState state = PicklisteDiagnosticsItemState.pending;
  String value = '';

  PicklisteDiagnosticsItem(this.keyname);

  String get testKexPrefix => 'settings_diagnostics_item_$keyname';
  String get testKeyState => state.toString().split('.')[1];
}
