import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/enums/testkey.dart';
import '../../../../../core/widgets/misc/loading_spinner.dart';
import '../../../domain/models/items.dart';
import '../../bloc/bloc.dart';
import '../../bloc/event.dart';
import '../../bloc/state.dart';
import '../widgets/items_widget.dart';

class PicklisteDiagnosticsPage extends StatelessWidget {
  final String title;
  final String toastText;
  final String infoText;
  final PicklisteDiagnosticsItems items;
  final Future<String> houseNumberURL;

  const PicklisteDiagnosticsPage({
    super.key,
    required this.title,
    required this.toastText,
    required this.infoText,
    required this.items,
    required this.houseNumberURL,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PicklisteDiagnosticsBloc()..add(PicklisteDiagnosticsInitialize(items)),
      child: BlocBuilder<PicklisteDiagnosticsBloc, PicklisteDiagnosticsState>(
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () async => state is PicklisteDiagnosticsFinished,
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
    if (state is PicklisteDiagnosticsLoading) {
      return const PicklisteLoadingSpinner();
    }

    if (state is PicklisteDiagnosticsPending) {
      return PicklisteDiagnosticsItemsWidget(title, toastText, infoText, items, houseNumberURL, false);
    }

    if (state is PicklisteDiagnosticsFinished) {
      return PicklisteDiagnosticsItemsWidget(title, toastText, infoText, items, houseNumberURL, true);
    }

    return const SizedBox();
  }
}
