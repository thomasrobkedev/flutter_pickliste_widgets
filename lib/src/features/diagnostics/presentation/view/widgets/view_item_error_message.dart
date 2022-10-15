import 'package:flutter/material.dart';

import '../../../domain/models/item.dart';

class PicklisteDiagnosticsViewItemErrorMessage extends StatelessWidget {
  final PicklisteDiagnosticsItem item;

  const PicklisteDiagnosticsViewItemErrorMessage({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 24),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              item.value,
              key: ValueKey('${item.testKexPrefix}_error'),
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}
