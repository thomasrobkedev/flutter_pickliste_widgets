import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/testkey.dart';
import '../../../../core/extensions/list_divided.dart';
import '../../../../core/widgets/loading_spinner.dart';
import '../../../../core/widgets/misc/intro_container.dart';
import '../../../../core/widgets/toast/toast.dart';
import '../../domain/models/item.dart';
import '../../domain/models/items.dart';
import '../../injector.dart';
import '../bloc/bloc.dart';
import 'widgets/view_item.dart';

class PicklisteDiagnosticsPage extends StatelessWidget {
  final String title;
  final String toastText;
  final String infoText;
  final PicklisteDiagnosticsItems items;
  final String houseNumberURL;

  PicklisteDiagnosticsPage({
    Key? key,
    required this.title,
    required this.toastText,
    required this.infoText,
    required this.items,
    required this.houseNumberURL,
  }) : super(key: key) {
    initializePicklisteDianosticsDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PicklisteDiagnosticsBloc(injector(), injector(), injector(), injector(), injector())..initialize(items),
      child: BlocBuilder<PicklisteDiagnosticsBloc, PicklisteDiagnosticsState>(
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () async => state.isFinished,
            child: Scaffold(
              key: ValueKey(PicklisteTestkey.diagnostics_page.toString()),
              appBar: AppBar(title: Text(title)),
              body: _body(context, state),
              backgroundColor: Colors.white,
            ),
          );
        },
      ),
    );
  }

  Widget _body(BuildContext context, PicklisteDiagnosticsState state) {
    if (state.isLoading) {
      return const LoadingSpinner();
    }

    final labels = <PicklisteDiagnosticsItem, String>{
      state.items.dateTime: 'Datum/Zeit',
      state.items.versionBuild: 'Version',
      state.items.house: 'Haus',
      state.items.houseDevice: 'Haus / Gerät',
      state.items.mac: 'MAC-Adresse',
      state.items.serial: 'Seriennummer',
      state.items.ip: 'IP-Adresse',
      state.items.defaultGateway: 'Standard Gateway',
      state.items.wifiName: 'WLAN Name',
      state.items.wifiSignalStrength: 'WLAN Signalstärke',
      state.items.dns1: 'DNS Server 1',
      state.items.dns2: 'DNS Server 2',
      state.items.httpPuC: 'https://www.peek-cloppenburg.de',
      state.items.httpHousePic: houseNumberURL,
      state.items.httpHouse: houseNumberURL.replaceAll('_pic', ''),
      state.items.routes: 'Routes',
    };

    return PicklisteToast(
      textLarge: toastText,
      color: const Color.fromARGB(255, 255, 175, 0),
      autoTimeout: state.isFinished ? 1000 : null,
      testKey: ValueKey(PicklisteTestkey.diagnostics_toast.toString()),
      child: InteractiveViewer(
        panEnabled: false,
        minScale: 0.5,
        maxScale: 1,
        boundaryMargin: const EdgeInsets.all(double.infinity),
        child: Column(
          children: [
            PicklisteIntroContainer.withTextOnly(
              text: infoText,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(12, 8, 0, 8),
              child: Column(
                children: state.items.props //
                    .where((item) => item.getValue != null)
                    .map((item) => PicklisteDiagnosticsViewItem(label: labels[item]!, item: item))
                    .toListDivided(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
