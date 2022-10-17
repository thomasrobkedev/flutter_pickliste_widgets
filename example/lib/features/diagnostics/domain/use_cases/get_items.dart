import 'package:example/features/diagnostics/domain/use_cases/get_house_number_url.dart';
import 'package:flutter_pickliste_widgets/flutter_pickliste_widgets.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DiagnosticsUseCaseGetItems {
  PicklisteDiagnosticsItems call() {
    final items = PicklisteDiagnosticsItems();

    items.dateTime.getValue = () async => PicklisteDiagnosticsUseCaseGetDateTime().call();
    items.versionBuild.getValue = _getVersionBuild;
    items.houseDevice.getValue = () async => '471 / 1';
    items.mac.getValue = () async => '00:11:22:33:44:55';
    items.serial.getValue = () async => '1234567890';
    items.ip.getValue = NetworkInfo().getWifiIP;
    items.defaultGateway.getValue = NetworkInfo().getWifiGatewayIP;
    items.wifiName.getValue = NetworkInfo().getWifiName;
    items.httpPuC.getValue = () async => PicklisteDiagnosticsUseCaseGetHttp().call('http://www.peek-cloppenburg.de');
    items.httpHousePic.getValue = () async => PicklisteDiagnosticsUseCaseGetHttp().call(DiagnosticsUseCaseGetHouseNumberURL().call(withPic: true));
    items.httpHouse.getValue = () async => PicklisteDiagnosticsUseCaseGetHttp().call(DiagnosticsUseCaseGetHouseNumberURL().call(withPic: false));

    return items;
  }

  Future<String> _getVersionBuild() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return '${packageInfo.version}+${packageInfo.buildNumber}';
  }
}
