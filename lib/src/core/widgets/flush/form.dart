import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../enums/testkey.dart';
import '../../theme/theme_const.dart';
import '../form/text_field.dart';
import '../misc/intro_container.dart';
import 'container.dart';

class PicklisteFlushForm<T> extends StatefulWidget {
  final BuildContext context;
  final String introText;
  final String labelText;
  final String? okText;
  final String? cancelText;
  final String? failText;
  final bool password;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool Function(String) isValid;
  final T Function(String) getSuccessReturnValue;

  const PicklisteFlushForm({
    required this.context,
    required this.introText,
    required this.labelText,
    this.okText,
    this.cancelText,
    this.failText,
    this.password = false,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    required this.isValid,
    required this.getSuccessReturnValue,
    Key? key,
  }) : super(key: key);

  @override
  State<PicklisteFlushForm<T>> createState() => _PicklisteFlushFormState<T>();

  Future<T?> show() async {
    return await showModalBottomSheet<T>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      builder: (BuildContext context) => this,
    );
  }
}

class _PicklisteFlushFormState<T> extends State<PicklisteFlushForm<T>> {
  final controller = TextEditingController();
  final focusNode = FocusNode();
  bool isValid = true;

  void close(BuildContext context, T? value) {
    Navigator.of(context).pop<T>(value);
  }

  void submit(BuildContext context) {
    if (widget.isValid(controller.text)) {
      close(context, widget.getSuccessReturnValue(controller.text));
    } else {
      setState(() => isValid = false);
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PicklisteFlushContainer(
      context: context,
      testKey: const ValueKey('flush-form'),
      child: _content(context),
    );
  }

  Widget _content(BuildContext context) {
    return Column(
      children: [
        PicklisteIntroContainer.withTextOnly(text: widget.introText),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            children: [
              PicklisteTextField(
                controller: controller,
                focusNode: focusNode,
                password: widget.password,
                keyboardType: widget.keyboardType,
                inputFormatters: widget.inputFormatters,
                labelText: widget.labelText,
                onFieldSubmitted: (String _) => submit(context),
                onTapSelectAll: false,
                testKey: ValueKey(Testkey.flushForm_input.toString()),
              ),
              Visibility(
                visible: !isValid,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    key: ValueKey(Testkey.flushForm_error.toString()),
                    widget.failText ?? 'Ungültige Eingabe', // AppLocalizations.of(context)!.general__invalid_input,
                    style: const TextStyle(color: Colors.red, fontSize: kFontSizeSmall),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(color: Color(kContainerBorderColor)),
        SizedBox(
          height: 48,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _button(
                context,
                caption: widget.okText ?? 'OK', // AppLocalizations.of(context)!.general__ok,
                primary: true,
                onPressed: () => submit(context),
                testKey: ValueKey(Testkey.flushForm_ok.toString()),
              ),
              const VerticalDivider(color: Color(kContainerBorderColor)),
              _button(
                context,
                // TODO: Übersetzung
                caption: widget.cancelText ?? 'Abbrechen', // AppLocalizations.of(context)!.general__cancel,
                primary: false,
                onPressed: () => close(context, null),
                testKey: ValueKey(Testkey.flushForm_cancel.toString()),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _button(
    BuildContext context, {
    required String caption,
    required bool primary,
    required Function() onPressed,
    required ValueKey<String> testKey,
  }) {
    return Expanded(
      child: TextButton(
        key: testKey,
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: primary ? Colors.white : Colors.black,
          textStyle: const TextStyle(fontSize: kFontSizeDefault),
          backgroundColor: primary ? Theme.of(context).primaryColor : Colors.white,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          side: BorderSide.none,
        ),
        child: Text(caption),
      ),
    );
  }
}
