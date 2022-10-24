import 'package:flutter/material.dart';

import '../../../domain/models/item.dart';

class PicklisteDiagnosticsItemIcon extends StatelessWidget {
  final PicklisteDiagnosticsItem item;

  const PicklisteDiagnosticsItemIcon({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      //   color: Colors.lightBlueAccent,
      alignment: Alignment.centerLeft,
      child: _icon(),
    );
  }

  Widget _icon() {
    final testKey = ValueKey('${item.testKexPrefix}_icon--${item.testKeyState}');

    switch (item.state) {
      case PicklisteDiagnosticsItemState.pending:
        return SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(key: testKey, strokeWidth: 1),
        );
      case PicklisteDiagnosticsItemState.success:
        return Icon(
          Icons.check,
          size: 18,
          color: Colors.green,
          key: testKey,
        );
      case PicklisteDiagnosticsItemState.fail:
        return Icon(
          Icons.close,
          size: 18,
          color: Colors.red,
          key: testKey,
        );
    }
  }
}
