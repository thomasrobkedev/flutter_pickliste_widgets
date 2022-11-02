import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../../core/enums/testkey.dart';
import '../../../../../core/extensions/list_divided.dart';
import '../../../../../core/widgets/misc/intro_container.dart';
import '../../../../../core/widgets/toast/toast.dart';
import '../../../domain/models/item.dart';
import '../../../domain/models/items.dart';
import 'item_widget.dart';

class PicklisteDiagnosticsItemsWidget extends StatefulWidget {
  final String title;
  final String toastText;
  final String infoText;
  final PicklisteDiagnosticsItems items;
  final Future<String> houseNumberURL;
  final bool finished;

  const PicklisteDiagnosticsItemsWidget(
    this.title,
    this.toastText,
    this.infoText,
    this.items,
    this.houseNumberURL,
    this.finished, {
    super.key,
  });

  @override
  State<PicklisteDiagnosticsItemsWidget> createState() => _PicklisteDiagnosticsItemsWidgetState();
}

class _PicklisteDiagnosticsItemsWidgetState extends State<PicklisteDiagnosticsItemsWidget> {
  int initialMillisecondsSinceEpoch = 0;
  String houseNumberURL = '';

  @override
  void initState() {
    initialMillisecondsSinceEpoch = DateTime.now().millisecondsSinceEpoch;
    widget.houseNumberURL.then((value) => setState(() => houseNumberURL = value));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sortOrder = <PicklisteDiagnosticsItem>[
      widget.items.dateTime,
      widget.items.versionBuild,
      widget.items.house,
      widget.items.houseDevice,
      widget.items.mac,
      widget.items.serial,
      widget.items.ip,
      widget.items.wifiName,
      widget.items.wifiSignalStrength,
      widget.items.httpPuC,
      widget.items.httpHousePic,
      widget.items.httpHouse,
      widget.items.dns1,
      widget.items.dns2,
      widget.items.defaultGateway,
      widget.items.routes,
    ];

    final labels = <PicklisteDiagnosticsItem, String>{
      widget.items.dateTime: 'Datum/Zeit',
      widget.items.versionBuild: 'Version',
      widget.items.house: 'Haus',
      widget.items.houseDevice: 'Haus / Gerät',
      widget.items.mac: 'MAC-Adresse',
      widget.items.serial: 'Seriennummer',
      widget.items.ip: 'IP-Adresse',
      widget.items.defaultGateway: 'Standard Gateway',
      widget.items.wifiName: 'WLAN Name',
      widget.items.wifiSignalStrength: 'WLAN Signalstärke',
      widget.items.dns1: 'DNS Server 1',
      widget.items.dns2: 'DNS Server 2',
      widget.items.httpPuC: 'http://www.peek-cloppenburg.de',
      widget.items.httpHousePic: houseNumberURL,
      widget.items.httpHouse: houseNumberURL.replaceAll('_pic', ''),
      widget.items.routes: 'Routes',
    };

    final props = widget.items.props.where((item) => item.getValue != null).toList();

    props.sort(
      (a, b) {
        if (sortOrder.contains(a) && sortOrder.contains(b)) {
          return sortOrder.indexOf(a).compareTo(sortOrder.indexOf(b));
        }
        if (sortOrder.contains(a) && sortOrder.contains(b)) {
          return -1;
        }
        if (sortOrder.contains(b)) {
          return 1;
        }
        return 0;
      },
    );

    final elapsed = DateTime.now().millisecondsSinceEpoch - initialMillisecondsSinceEpoch;
    final autoTimeout = max(0, 3000 - elapsed);

    return PicklisteToast(
      textLarge: widget.toastText,
      color: const Color.fromARGB(255, 255, 175, 0),
      autoTimeout: widget.finished ? autoTimeout : null,
      testKey: ValueKey(PicklisteTestkey.diagnostics_toast.toString()),
      child: SingleChildScrollView(
        child: InteractiveViewer(
          panEnabled: false,
          minScale: 0.5,
          maxScale: 1,
          boundaryMargin: const EdgeInsets.all(double.infinity),
          child: Column(
            children: [
              PicklisteIntroContainer.withTextOnly(text: widget.infoText),
              Container(
                padding: const EdgeInsets.fromLTRB(12, 8, 0, 8),
                child: Column(
                  children: props
                      .map(
                        (item) => PicklisteDiagnosticsItemWidget(
                          item: item,
                          label: labels[item]!,
                          isRoutes: item == widget.items.routes,
                        ),
                      )
                      .toListDivided(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
