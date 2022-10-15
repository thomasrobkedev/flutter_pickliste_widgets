import 'package:flutter/material.dart';

import '../../../domain/models/item.dart';

class PicklisteDiagnosticsViewItemValue extends StatelessWidget {
  final PicklisteDiagnosticsItem item;

  const PicklisteDiagnosticsViewItemValue({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      item.value,
      key: ValueKey('${item.testKexPrefix}_value'),
      style: const TextStyle(color: Colors.black87),
    );
  }
}
