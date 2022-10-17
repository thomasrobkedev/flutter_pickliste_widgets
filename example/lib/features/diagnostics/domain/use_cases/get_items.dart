import 'package:example/features/diagnostics/domain/use_cases/get_house_number_url.dart';
import 'package:flutter_pickliste_widgets/flutter_pickliste_widgets.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DiagnosticsUseCaseGetItems {
  PicklisteDiagnosticsItems call() {
    final items = PicklisteDiagnosticsItems();

    items.dateTime.getValue = PicklisteDiagnosticsUseCaseGetDateTime().call();
    items.versionBuild.getValue = _getVersionBuild();
    items.house.getValue = Future.value('471');
    items.houseDevice.getValue = Future.value('471 / 1');
    items.mac.getValue = Future.value('00:11:22:33:44:55');
    items.serial.getValue = Future.value('1234567890');
    items.ip.getValue = NetworkInfo().getWifiIP();
    items.wifiName.getValue = NetworkInfo().getWifiName();
    items.wifiSignalStrength.getValue = Future.value('85 %');
    items.defaultGateway.getValue = NetworkInfo().getWifiGatewayIP();
    items.dns1.getValue = Future.value('192.168.1.1');
    items.dns2.getValue = Future.value('192.168.1.2');
    items.routes.getValue = Future.value('Destination -> Gateway\nfe80:: -> ::\n:: -> fe80::2\n');
    items.httpPuC.getValue = PicklisteDiagnosticsUseCaseGetHttp().call('http://www.peek-cloppenburg.de');
    items.httpHousePic.getValue = PicklisteDiagnosticsUseCaseGetHttp().call(DiagnosticsUseCaseGetHouseNumberURL().call(withPic: true));
    items.httpHouse.getValue = PicklisteDiagnosticsUseCaseGetHttp().call(DiagnosticsUseCaseGetHouseNumberURL().call(withPic: false));

    return items;
  }

  Future<String> _getVersionBuild() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return '${packageInfo.version}+${packageInfo.buildNumber}';
  }
}
