import 'package:flutter/material.dart';

import '../../../domain/models/item.dart';
import 'item_error_message.dart';
import 'item_icon.dart';
import 'item_label.dart';
import 'item_value.dart';

class PicklisteDiagnosticsItemWidget extends StatelessWidget {
  final String label;
  final PicklisteDiagnosticsItem item;

  const PicklisteDiagnosticsItemWidget({
    Key? key,
    required this.label,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey(item.testKexPrefix),
      padding: const EdgeInsets.fromLTRB(0, 6, 16, 6),
      child: Column(
        children: [
          Row(
            children: [
              PicklisteDiagnosticsItemIcon(item: item),
              PicklisteDiagnosticsItemLabel(item: item, label: label),
              const Spacer(),
              Visibility(
                visible: item.state != PicklisteDiagnosticsItemState.fail && item.value.isNotEmpty,
                child: PicklisteDiagnosticsItemValue(item: item),
              ),
            ],
          ),
          Visibility(
            visible: item.state == PicklisteDiagnosticsItemState.fail && item.value.isNotEmpty,
            child: PicklisteDiagnosticsItemErrorMessage(item: item),
          ),
        ],
      ),
    );
  }
}
