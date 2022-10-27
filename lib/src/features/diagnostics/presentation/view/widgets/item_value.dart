import 'package:flutter/material.dart';

import '../../../../../core/theme/theme_const.dart';
import '../../../domain/models/item.dart';

class PicklisteDiagnosticsItemValue extends StatelessWidget {
  final PicklisteDiagnosticsItem item;
  final bool isRoutes;

  const PicklisteDiagnosticsItemValue({
    Key? key,
    required this.item,
    required this.isRoutes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isRoutes) {
      return Expanded(
        child: Text(
          item.value,
          textAlign: TextAlign.right,
          key: ValueKey('${item.testKexPrefix}_value'),
        ),
      );
    }

    final routes = item.value.split('\n').where((str) => str.trim() != '');
    final destinations = routes.map((route) => route.split('->')[0].trim());
    final gateways = routes.map((route) => route.split('->')[1].trim());

    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            destinations.join('\n'),
            textAlign: TextAlign.right,
            style: const TextStyle(height: 1.2),
          ),
          Text(
            destinations.map((_) => '  ➔  ').join('\n'),
            style: const TextStyle(height: 1.2 * PicklisteThemeConstants.kFontSizeDefault / PicklisteThemeConstants.kFontSizeSmall, fontSize: PicklisteThemeConstants.kFontSizeSmall),
          ),
          Text(
            gateways.join('\n'),
            style: const TextStyle(height: 1.2),
          ),
        ],
      ),
    );
  }
}
