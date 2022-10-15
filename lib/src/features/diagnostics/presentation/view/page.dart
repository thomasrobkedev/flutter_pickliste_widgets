import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/testkey.dart';
import '../../../../core/extensions/list_divided.dart';
import '../../../../core/widgets/loading_spinner.dart';
import '../../../../core/widgets/toast/toast.dart';
import '../bloc/bloc.dart';
import 'widgets/view_item.dart';

class PicklisteDiagnosticsPage extends StatelessWidget {
  static const routeName = '/pickliste/diagnostics';

  const PicklisteDiagnosticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PicklisteDiagnosticsBloc(),
      child: BlocBuilder<PicklisteDiagnosticsBloc, PicklisteDiagnosticsState>(
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () async => state.isFinished,
            child: Scaffold(
              key: ValueKey(Testkey.diagnostics_page.toString()),
              appBar: AppBar(title: const Text('Diagnose')), // TODO: Übersetzung
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

    return SingleChildScrollView(
      child: InteractiveViewer(
        panEnabled: false,
        minScale: 0.5,
        maxScale: 1,
        boundaryMargin: const EdgeInsets.all(double.infinity),
        child: Column(
          children: [
            PicklisteToast(
              textLarge: 'Bitte warten', // TODO: Übersetzung
              color: const Color.fromARGB(255, 255, 175, 0),
              active: true,
              autoTimeout: state.isFinished ? 1000 : null,
              animationDuration: 0,
              testKey: ValueKey(Testkey.diagnostics_toast.toString()),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(12, 8, 0, 8),
              child: Column(
                children: [
                  PicklisteDiagnosticsViewItem(label: 'Datum/Zeit', item: state.items.dateTime),
                  PicklisteDiagnosticsViewItem(label: 'Version', item: state.items.versionBuild),
                  PicklisteDiagnosticsViewItem(label: 'Haus / Gerät', item: state.items.houseDevice),
                  PicklisteDiagnosticsViewItem(label: 'MAC-Adresse', item: state.items.mac),
                  PicklisteDiagnosticsViewItem(label: 'Seriennummer', item: state.items.serial),
                  PicklisteDiagnosticsViewItem(label: 'IP-Adresse', item: state.items.ip),
                  PicklisteDiagnosticsViewItem(label: 'Standard Gateway', item: state.items.defaultGateway),
                  PicklisteDiagnosticsViewItem(label: 'WLAN Name', item: state.items.wifiName),

                  // TODO: WLAN Signalstärke, @see: https://jira.puc.services/browse/WEBPICK-805
                  // PicklisteDiagnosticsViewItem(label: 'WLAN Signalstärke', item: state.items.wifiSignalStrength),

                  PicklisteDiagnosticsViewItem(label: 'DNS Server 1', item: state.items.dns1),
                  PicklisteDiagnosticsViewItem(label: 'DNS Server 2', item: state.items.dns2),
                  PicklisteDiagnosticsViewItem(label: 'http://www.peek-cloppenburg.de', item: state.items.httpPuC),
                  PicklisteDiagnosticsViewItem(label: state.houseNumberURL, item: state.items.httpHousePic),
                  PicklisteDiagnosticsViewItem(label: state.houseNumberURL.replaceAll('_pic', ''), item: state.items.httpHouse),
                ].toListDivided(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
