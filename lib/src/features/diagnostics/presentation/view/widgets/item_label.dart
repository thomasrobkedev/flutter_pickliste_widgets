import 'package:flutter/material.dart';

import '../../../../../core/theme/theme_const.dart';
import '../../../domain/models/item.dart';

class PicklisteDiagnosticsItemLabel extends StatefulWidget {
  final PicklisteDiagnosticsItem item;
  final Future<String> houseNumberURL;

  const PicklisteDiagnosticsItemLabel({
    Key? key,
    required this.item,
    required this.houseNumberURL,
  }) : super(key: key);

  @override
  State<PicklisteDiagnosticsItemLabel> createState() => _PicklisteDiagnosticsItemLabelState();
}

class _PicklisteDiagnosticsItemLabelState extends State<PicklisteDiagnosticsItemLabel> {
  String houseNumberURL = '';

  @override
  void initState() {
    widget.houseNumberURL.then((value) => setState(() => houseNumberURL = value));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final labels = <String, String>{
      'dateTime': 'Datum/Zeit',
      'versionBuild': 'Version',
      'house': 'Haus',
      'houseDevice': 'Haus / Gerät',
      'mac': 'MAC-Adresse',
      'serial': 'Seriennummer',
      'ip': 'IP-Adresse',
      'defaultGateway': 'Standard Gateway',
      'wifiName': 'WLAN Name',
      'wifiSignalStrength': 'WLAN Signalstärke',
      'dns1': 'DNS Server 1',
      'dns2': 'DNS Server 2',
      'httpPuC': 'http://www.peek-cloppenburg.de',
      'httpHousePic': houseNumberURL,
      'httpHouse': houseNumberURL.replaceAll('_pic', ''),
      'routes': 'Routes',
    };

    return Text(
      labels[widget.item.keyname]!,
      key: ValueKey('${widget.item.testKexPrefix}_label'),
      style: const TextStyle(fontSize: PicklisteThemeConstants.kFontSizeSmall, fontWeight: FontWeight.bold),
    );
  }
}
