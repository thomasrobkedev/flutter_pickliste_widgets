import 'package:flutter/material.dart';

import '../../../../../core/theme/theme_const.dart';
import '../../../domain/models/item.dart';

class PicklisteDiagnosticsItemLabel extends StatelessWidget {
  final PicklisteDiagnosticsItem item;
  final String label;

  const PicklisteDiagnosticsItemLabel({
    Key? key,
    required this.item,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      key: ValueKey('${item.testKexPrefix}_label'),
      style: const TextStyle(fontSize: PicklisteThemeConstants.kFontSizeSmall, fontWeight: FontWeight.bold),
    );
  }
}
