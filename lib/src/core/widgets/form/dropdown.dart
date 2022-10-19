import 'package:flutter/material.dart';

import '../../theme/theme_const.dart';
import 'field.dart';

class PicklisteDropdown<T> extends StatelessWidget {
  final ValueKey<String>? testKey;
  final List<DropdownMenuItem<T>> items;
  final T value;
  final Function(T?)? onChanged;
  final String labelText;
  final bool enabled;
  final FocusNode? focusNode;

  const PicklisteDropdown({
    Key? key,
    this.testKey,
    required this.items,
    required this.value,
    required this.onChanged,
    required this.labelText,
    this.enabled = true,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PicklisteField(
      enabled: enabled,
      child: Theme(
        data: Theme.of(context).copyWith(visualDensity: const VisualDensity(vertical: -1)),
        child: DropdownButtonFormField<T>(
          key: testKey,
          items: items,
          value: value,
          onChanged: enabled ? onChanged : null,
          focusNode: focusNode,
          style: const TextStyle(color: Colors.black, fontSize: kFontSizeDefault),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            border: InputBorder.none,
            labelText: labelText.replaceAll(':', ''),
            labelStyle: const TextStyle(color: Color(kLabelColor), fontSize: kFontSizeDefault),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            enabled: enabled,
          ),
        ),
      ),
    );
  }
}
