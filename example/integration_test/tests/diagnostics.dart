import 'package:example/core/enums/testkey.dart';
import 'package:flutter_pickliste_widgets/flutter_pickliste_widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../main_test.dart';

class Diagnostics {
  void call() {
    testWidgets(description(this, ''), (tester) async {
      await startupApp(tester);

      await exists(Testkey.home_page);
      await tap(Testkey.home_menuDiagnostics);

      /// Beim Laden der Seite ist der "Bitte warten" Toast gleich sichtbar
      /// Nach max. 10 Sekunden werden alle noch laufenden async items abgebrochen. 1 weitere Sekunde später geht der Toast weg - mit einer Animation von 350 ms
      /// 10 + 1 + 0,350 < 12
      await exists(PicklisteTestkey.diagnostics_toast.active);
      await equalsString(PicklisteTestkey.diagnostics_toast.append('_large'), 'Bitte warten');
      await wait(12);
      await exists(PicklisteTestkey.diagnostics_toast.inactive);

      // Wir checken hier die Labels.
      await equalsString('pickliste_diagnostics_item_dateTime_label', 'Datum/Zeit');
      await equalsString('pickliste_diagnostics_item_versionBuild_label', 'Version');
      await equalsString('pickliste_diagnostics_item_houseDevice_label', 'Haus / Gerät');
      await equalsString('pickliste_diagnostics_item_mac_label', 'MAC-Adresse');
      await equalsString('pickliste_diagnostics_item_serial_label', 'Seriennummer');
      await equalsString('pickliste_diagnostics_item_ip_label', 'IP-Adresse');
      await equalsString('pickliste_diagnostics_item_wifiName_label', 'WLAN Name');
      await equalsString('pickliste_diagnostics_item_wifiSignalStrength_label', 'WLAN Signalstärke');
      await equalsString('pickliste_diagnostics_item_defaultGateway_label', 'Standard Gateway');
      await equalsString('pickliste_diagnostics_item_dns1_label', 'DNS Server 1');
      await equalsString('pickliste_diagnostics_item_dns2_label', 'DNS Server 2');
      await equalsString('pickliste_diagnostics_item_routes_label', 'Routes');
      await equalsString('pickliste_diagnostics_item_httpPuC_label', 'http://www.peek-cloppenburg.de');
      await equalsString('pickliste_diagnostics_item_httpHousePic_label', 'http://h471_pic.puc/pl07');
      await equalsString('pickliste_diagnostics_item_httpHouse_label', 'http://h471.puc/pl07');

      //................................
      // Wir checken die Formatierung
      //................................
      // date, time and timezone
      final date = await getTextFromField('pickliste_diagnostics_item_dateTime_value');
      await equalsTrue(RegExp(r'^\d{4}(-\d\d){2}\s\d\d(:\d\d){2}\s[+-]\d\d?(h|\:\d\d)$', multiLine: true).hasMatch(date));

      // Version und Build
      final versionBuild = await getTextFromField('pickliste_diagnostics_item_versionBuild_value');
      await equalsTrue(RegExp(r'^\d{1,4}\.\d{1,4}\.\d{1,4}\+\d{1,4}$', multiLine: true).hasMatch(versionBuild));

      // Haus und Gerät
      final houseDevice = await getTextFromField('pickliste_diagnostics_item_houseDevice_value');
      await equalsTrue(RegExp(r'^\d{1,4} / \d{1,4}$', multiLine: true).hasMatch(houseDevice));

      // MAC-Adresse
      final macAdresse = await getTextFromField('pickliste_diagnostics_item_mac_value');
      await equalsTrue(RegExp(r'^([0-9a-f]{2}[:-]){5}([0-9a-f]{2})$', multiLine: true, caseSensitive: false).hasMatch(macAdresse));

      // Seriennummer
      final serial = await getTextFromField('pickliste_diagnostics_item_serial_value');
      await equalsTrue(RegExp(r'^[a-z0-9]+$', multiLine: true, caseSensitive: false).hasMatch(serial));

      // IP-Adresse
      final ipAdresse = await getTextFromField('pickliste_diagnostics_item_ip_value');
      await equalsTrue(RegExp(r'^(\d{1,3}\.){3}\d{1,3}$', multiLine: true).hasMatch(ipAdresse));

      // Default Gateway
      final defaultGateway = await getTextFromField('pickliste_diagnostics_item_defaultGateway_value');
      await equalsTrue(RegExp(r'^(\d{1,3}\.){3}\d{1,3}$', multiLine: true).hasMatch(defaultGateway));

      // IP-Adresse
      final wifiSignalStrength = await getTextFromField('pickliste_diagnostics_item_wifiSignalStrength_value');
      await equalsTrue(RegExp(r'^\d{1,3} %$', multiLine: true).hasMatch(wifiSignalStrength));

      await goHome();
    });
  }
}
