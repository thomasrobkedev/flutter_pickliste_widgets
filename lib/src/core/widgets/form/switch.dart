import 'package:flutter/material.dart';

import '../../theme/global_theme.dart';
import 'field.dart';

class PicklisteSwitch extends StatelessWidget {
  final ValueKey<String>? testKey;
  final String title;
  final bool value;
  final Function(bool?) onChanged;
  final bool enabled;

  const PicklisteSwitch({
    Key? key,
    this.testKey,
    required this.title,
    required this.value,
    required this.onChanged,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PicklisteField(
      enabled: enabled,
      child: Theme(
        data: Theme.of(context).copyWith(visualDensity: const VisualDensity(vertical: -3)),
        child: SwitchListTile(
          key: testKey,
          contentPadding: const EdgeInsets.only(left: 8),
          title: Text(title, style: TextStyle(color: enabled ? Colors.black : const Color(PicklisteThemeCreator.kLabelColor), fontSize: PicklisteThemeCreator.kFontSizeDefault)),
          value: value,
          onChanged: enabled ? onChanged : null,
          dense: true,
          tileColor: Colors.transparent,
        ),
      ),
    );
  }
}
