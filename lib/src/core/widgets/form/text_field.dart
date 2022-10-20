import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/theme_const.dart';
import 'field.dart';

class PicklisteTextField extends StatefulWidget {
  final ValueKey<String>? testKey;
  final TextEditingController controller;
  final String labelText;
  final bool enabled;
  final Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool onTapSelectAll;
  final bool readOnly;
  final String? hint;
  final bool password;

  const PicklisteTextField({
    Key? key,
    this.testKey,
    required this.controller,
    required this.labelText,
    this.enabled = true,
    this.onFieldSubmitted,
    this.focusNode,
    this.keyboardType = TextInputType.number,
    this.inputFormatters,
    this.onTapSelectAll = true,
    this.readOnly = false,
    this.hint,
    this.password = false,
  }) : super(key: key);

  @override
  State<PicklisteTextField> createState() => _PicklisteTextFieldState();
}

class _PicklisteTextFieldState extends State<PicklisteTextField> {
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return PicklisteField(
      enabled: widget.enabled,
      child: TextFormField(
        obscureText: widget.password && !passwordVisible,
        enableSuggestions: false,
        autocorrect: false,
        key: widget.testKey,
        controller: widget.controller,
        focusNode: widget.focusNode,
        onFieldSubmitted: widget.onFieldSubmitted,
        keyboardType: widget.keyboardType,
        textInputAction: TextInputAction.next,
        inputFormatters: widget.inputFormatters,
        readOnly: widget.readOnly,
        style: TextStyle(color: widget.enabled ? Colors.black : const Color(PicklisteThemeConstants.kLabelColor), fontSize: PicklisteThemeConstants.kFontSizeDefault),
        decoration: InputDecoration(
          hintText: widget.hint,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          border: InputBorder.none,
          labelText: widget.labelText.replaceAll(':', ''),
          labelStyle: const TextStyle(color: Color(PicklisteThemeConstants.kLabelColor), fontSize: PicklisteThemeConstants.kFontSizeDefault),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          enabled: widget.enabled,
          suffixIconConstraints: const BoxConstraints(maxHeight: 24),
          suffixIcon: widget.password
              ? IconButton(
                  key: widget.testKey == null ? null : ValueKey('${widget.testKey!.value}_togglePasswordVisibility'),
                  padding: const EdgeInsets.only(top: 4),
                  iconSize: 16,
                  icon: Icon(passwordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                  onPressed: () => setState(() => passwordVisible = !passwordVisible),
                )
              : null,
        ),
        onTap: widget.onTapSelectAll
            ? () => widget.controller.selection = TextSelection(
                  baseOffset: 0,
                  extentOffset: widget.controller.value.text.length,
                )
            : null,
      ),
    );
  }
}
