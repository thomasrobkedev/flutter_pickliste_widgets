import 'package:flutter_pickliste_widgets/flutter_pickliste_widgets.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'get_house_number_url.dart';

class DiagnosticsUseCaseGetItems {
  final PicklisteDiagnosticsUseCaseGetDateTime _getDateTime;
  final PicklisteDiagnosticsUseCaseGetHttp _getHttp;
  final DiagnosticsUseCaseGetHouseNumberURL _getHouseNumberURL;

  DiagnosticsUseCaseGetItems(this._getDateTime, this._getHttp, this._getHouseNumberURL);

  PicklisteDiagnosticsItems call() {
    final items = PicklisteDiagnosticsItems();

    items.dateTime.getValue = () => _getDateTime();
    items.versionBuild.getValue = () => _getVersionBuild();
    items.house.getValue = () => Future.value('471');
    items.houseDevice.getValue = () => Future.value('471 / 1');
    items.mac.getValue = () => Future.value('00:11:22:33:44:55');
    items.serial.getValue = () => Future.value('1234567890');
    items.ip.getValue = () => NetworkInfo().getWifiIP();
    items.wifiName.getValue = () => NetworkInfo().getWifiName();
    items.wifiSignalStrength.getValue = () => Future.value('85 %');
    items.defaultGateway.getValue = () => NetworkInfo().getWifiGatewayIP();
    items.dns1.getValue = () => Future.value('192.168.1.1');
    items.dns2.getValue = () => Future.value('192.168.1.2');
    items.routes.getValue = () => Future.value('Destination -> Gateway\nfe80:: -> ::\n:: -> fe80::2\n');
    items.httpPuC.getValue = () => _getHttp('https://www.peek-cloppenburg.de');
    items.httpHousePic.getValue = () => _getHttp(_getHouseNumberURL(withPic: true));
    items.httpHouse.getValue = () => _getHttp(_getHouseNumberURL(withPic: false));

    return items;
  }

  Future<String> _getVersionBuild() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return '${packageInfo.version}+${packageInfo.buildNumber}';
  }
}
