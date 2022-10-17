import 'package:equatable/equatable.dart';

import 'item.dart';

class PicklisteDiagnosticsItems extends Equatable {
  final dateTime = PicklisteDiagnosticsItem('dateTime');
  final versionBuild = PicklisteDiagnosticsItem('versionBuild');
  final houseDevice = PicklisteDiagnosticsItem('houseDevice');
  final mac = PicklisteDiagnosticsItem('mac');
  final serial = PicklisteDiagnosticsItem('serial');
  final ip = PicklisteDiagnosticsItem('ip');
  final wifiName = PicklisteDiagnosticsItem('wifiName');
//   final wifiSignalStrength = PicklisteDiagnosticsItem('wifiSignalStrength');
  final defaultGateway = PicklisteDiagnosticsItem('defaultGateway');
  final httpPuC = PicklisteDiagnosticsItem('httpPuC');
  final httpHousePic = PicklisteDiagnosticsItem('httpHousePic');
  final httpHouse = PicklisteDiagnosticsItem('httpHouse');

  bool get isFinished => props.every((item) => item.state != PicklisteDiagnosticsItemState.pending);

  @override
  List<PicklisteDiagnosticsItem> get props => [
        dateTime,
        versionBuild,
        houseDevice,
        mac,
        serial,
        ip,
        wifiName,
        // wifiSignalStrength,
        defaultGateway,
        httpPuC,
        httpHousePic,
        httpHouse,
      ];
}
