import 'dart:math';

import 'package:flutter/material.dart';

import '../../../domain/models/item.dart';
import 'item_value_route.dart';

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
    final flexDestination = _maxChars(routes, 0);
    final flexGateway = _maxChars(routes, 1);

    return Expanded(
      child: Column(
        children: routes
            .map(
              (route) => PicklisteDiagnosticsItemValueRoute(
                destination: route.split('->')[0].trim(),
                gateway: route.split('->')[1].trim(),
                flexDestination: flexDestination,
                flexGateway: flexGateway,
              ),
            )
            .toList(),
      ),
    );
  }

  int _maxChars(Iterable<String> routes, int index) {
    return routes //
        .map((route) => route.split('->')[index].trim().replaceAll(':', ''))
        .fold<int>(0, (p, c) => max(p, c.length));
  }
}
