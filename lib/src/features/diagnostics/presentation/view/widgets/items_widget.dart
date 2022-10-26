import 'package:flutter/material.dart';

import '../../../../../core/enums/testkey.dart';
import '../../../../../core/extensions/list_divided.dart';
import '../../../../../core/widgets/misc/intro_container.dart';
import '../../../../../core/widgets/toast/toast.dart';
import '../../../domain/models/items.dart';
import 'item_widget.dart';

class PicklisteDiagnosticsItemsWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return PicklisteToast(
      textLarge: toastText,
      color: const Color.fromARGB(255, 255, 175, 0),
      autoTimeout: finished ? 1000 : null,
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
                children: items.props //
                    .where((item) => item.getValue != null)
                    .map(
                      (item) => PicklisteDiagnosticsItemWidget(
                        item: item,
                        isRoutes: item == items.routes,
                        houseNumberURL: houseNumberURL,
                      ),
                    )
                    .toListDivided(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
