import 'package:equatable/equatable.dart';

import 'item.dart';

class PicklisteDiagnosticsItems extends Equatable {
  final dateTime = PicklisteDiagnosticsItem('dateTime');
  final versionBuild = PicklisteDiagnosticsItem('versionBuild');
  final house = PicklisteDiagnosticsItem('house');
  final houseDevice = PicklisteDiagnosticsItem('houseDevice');
  final mac = PicklisteDiagnosticsItem('mac');
  final serial = PicklisteDiagnosticsItem('serial');
  final ip = PicklisteDiagnosticsItem('ip');
  final wifiName = PicklisteDiagnosticsItem('wifiName');
  final wifiSignalStrength = PicklisteDiagnosticsItem('wifiSignalStrength');
  final dns1 = PicklisteDiagnosticsItem('dns1');
  final dns2 = PicklisteDiagnosticsItem('dns2');
  final routes = PicklisteDiagnosticsItem('routes');
  final defaultGateway = PicklisteDiagnosticsItem('defaultGateway');
  final httpPuC = PicklisteDiagnosticsItem('httpPuC');
  final httpHousePic = PicklisteDiagnosticsItem('httpHousePic');
  final httpHouse = PicklisteDiagnosticsItem('httpHouse');

  bool get isFinished => props //
      .where((item) => item.getValue != null)
      .every((item) => item.state != PicklisteDiagnosticsItemState.pending);

  @override
  List<PicklisteDiagnosticsItem> get props => [
        dateTime,
        versionBuild,
        house,
        houseDevice,
        mac,
        serial,
        ip,
        wifiName,
        wifiSignalStrength,
        dns1,
        dns2,
        routes,
        defaultGateway,
        httpPuC,
        httpHousePic,
        httpHouse,
      ];
}
