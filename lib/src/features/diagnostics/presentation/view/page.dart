import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/testkey.dart';
import '../../../../core/extensions/list_divided.dart';
import '../../../../core/widgets/loading_spinner.dart';
import '../../../../core/widgets/misc/intro_container.dart';
import '../../../../core/widgets/toast/toast.dart';
import '../../domain/models/item.dart';
import '../../domain/models/items.dart';
import '../bloc/bloc.dart';
import 'widgets/view_item.dart';

class PicklisteDiagnosticsPage extends StatelessWidget {
  static const routeName = '/pickliste/diagnostics';
  final PicklisteDiagnosticsItems Function() getItems;
  final String houseNumberURL;

  const PicklisteDiagnosticsPage({
    Key? key,
    required this.getItems,
    required this.houseNumberURL,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PicklisteDiagnosticsBloc(getItems, houseNumberURL),
      child: BlocBuilder<PicklisteDiagnosticsBloc, PicklisteDiagnosticsState>(
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () async => state.isFinished,
            child: Scaffold(
              key: ValueKey(Testkey.diagnostics_page.toString()),
              appBar: AppBar(title: const Text('Diagnose')), // AppLocalizations.of(context)!.menu__app_settings_diagnostics
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
      textLarge: 'Bitte warten', // AppLocalizations.of(context)!.general__please_wait,
      color: const Color.fromARGB(255, 255, 175, 0),
      autoTimeout: state.isFinished ? 1000 : null,
      testKey: ValueKey(Testkey.diagnostics_toast.toString()),
      child: InteractiveViewer(
        panEnabled: false,
        minScale: 0.5,
        maxScale: 1,
        boundaryMargin: const EdgeInsets.all(double.infinity),
        child: Column(
          children: [
            PicklisteIntroContainer.withTextOnly(
              text: 'Bitte machen Sie ein Foto von den unten aufgeführten Punkten und schicken Sie dies an Ihren IT-Ansprechpartner.', // AppLocalizations.of(context)!.diagnostic__instructions,
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
