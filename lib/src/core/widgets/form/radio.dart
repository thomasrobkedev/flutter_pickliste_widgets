import 'package:flutter/material.dart';

import '../../theme/global_theme.dart';
import 'field.dart';

class PicklisteRadio<T> extends StatelessWidget {
  final ValueKey<String>? testKey;
  final String title;
  final T value;
  final T groupValue;
  final Function(T?) onChanged;
  final bool enabled;

  const PicklisteRadio({
    Key? key,
    this.testKey,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PicklisteField(
      enabled: enabled,
      child: Theme(
        data: Theme.of(context).copyWith(visualDensity: const VisualDensity(vertical: -3)),
        child: RadioListTile<T>(
          key: testKey,
          contentPadding: const EdgeInsets.only(left: 8),
          title: Container(
            transform: Matrix4.translationValues(-8, 0, 0),
            child: Text(title, style: TextStyle(color: enabled ? Colors.black : const Color(PicklisteThemeCreator.kLabelColor), fontSize: PicklisteThemeCreator.kFontSizeDefault)),
          ),
          value: value,
          groupValue: groupValue,
          onChanged: enabled ? onChanged : null,
          dense: true,
          tileColor: Colors.transparent,
        ),
      ),
    );
  }
}
