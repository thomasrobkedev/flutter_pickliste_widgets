import 'package:flutter/material.dart';

import '../../../domain/models/item.dart';
import 'view_item_error_message.dart';
import 'view_item_icon.dart';
import 'view_item_label.dart';
import 'view_item_value.dart';

class PicklisteDiagnosticsViewItem extends StatelessWidget {
  final String label;
  final PicklisteDiagnosticsItem item;

  const PicklisteDiagnosticsViewItem({
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
              PicklisteDiagnosticsViewItemIcon(item: item),
              PicklisteDiagnosticsViewItemLabel(item: item, label: label),
              const Spacer(),
              Visibility(
                visible: item.state != PicklisteDiagnosticsItemState.fail && item.value.isNotEmpty,
                child: PicklisteDiagnosticsViewItemValue(item: item),
              ),
            ],
          ),
          Visibility(
            visible: item.state == PicklisteDiagnosticsItemState.fail && item.value.isNotEmpty,
            child: PicklisteDiagnosticsViewItemErrorMessage(item: item),
          ),
        ],
      ),
    );
  }
}
