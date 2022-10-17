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
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Text(
        item.value.split('\n').where((str) => str.trim() != '').join('\n'),
        key: ValueKey('${item.testKexPrefix}_value'),
        style: const TextStyle(color: Colors.black87),
      ),
    );
  }
}
