import 'package:flutter/material.dart';
import 'package:flutter_pickliste_widgets/flutter_pickliste_widgets.dart';

import '../../../../core/enums/testkey.dart';
import '../../../../core/utils/translations.dart';

class ToastPage extends StatefulWidget {
  static const routeName = 'toast';

  const ToastPage({super.key});

  @override
  State<ToastPage> createState() => _ToastPageState();
}

class _ToastPageState extends State<ToastPage> {
  bool active = false;
  int animationDuration = 350;
  bool startAnimation = false;
  int? autoTimeout;

  bool isLoading = false;
  int dropdownValue = 1;
  final textEditingController = TextEditingController();
  final focusNode = FocusNode();

  bool get isReset => active && !isLoading && dropdownValue == 1 && textEditingController.text == '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey(Testkey.toast_page.toString()),
      appBar: AppBar(title: const Text('Toast')),
      backgroundColor: const Color(PicklisteThemeConstants.kMenuBackgroundColor),
      body: _body(),
    );
  }

  Widget _body() {
    return PicklisteToast(
      textLarge: T()().general__please_wait,
      color: const Color.fromARGB(255, 255, 175, 0),
      active: active,
      animationDuration: animationDuration,
      startAnimation: startAnimation,
      autoTimeout: autoTimeout,
      testKey: ValueKey(Testkey.toast_toast.toString()),
      child: _content(),
    );
  }

  Widget _content() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            PicklisteSwitch(
              testKey: ValueKey(Testkey.toast_active.toString()),
              title: 'active',
              value: active,
              onChanged: (value) => setState(() => active = value!),
            ),
            // PicklisteCheckbox(
            //   testKey: const ValueKey('playground-checkbox'),
            //   title: 'Playground enabled/disabled',
            //   value: active,
            //   onChanged: (value) => setState(() => active = value!),
            // ),
            // PicklisteTextButton(
            //   testKey: const ValueKey('playground-textbutton-primary'),
            //   caption: 'Reset Playground',
            //   primary: true,
            //   enabled: !isReset,
            //   iconData: Icons.restore,
            //   onPressed: () => setState(
            //     () {
            //       focusNode.unfocus();
            //       textEditingController.clear();
            //       active = true;
            //       isLoading = false;
            //       dropdownValue = 1;
            //     },
            //   ),
            // ),
            // PicklisteTextButton(
            //   testKey: const ValueKey('playground-textbutton-danger'),
            //   caption: 'Disable Playground',
            //   enabled: active,
            //   danger: true,
            //   onPressed: () => setState(() => active = false),
            // ),
            // PicklisteTextButton(
            //   enabled: active,
            //   testKey: const ValueKey('playground-numberbutton'),
            //   caption: 'Dummy',
            //   number: 42,
            //   onPressed: () => null,
            // ),
            // PicklisteTextButton(
            //   testKey: const ValueKey('playground-textbutton-loading'),
            //   caption: isLoading ? 'Stop loading' : 'Start loading',
            //   enabled: active,
            //   loading: isLoading,
            //   onPressed: () => setState(() => isLoading = !isLoading),
            // ),
            // PicklisteDropdown<int>(
            //   enabled: active,
            //   testKey: const ValueKey('playground-dropdown'),
            //   value: dropdownValue,
            //   items: <DropdownMenuItem<int>>[
            //     const DropdownMenuItem(value: 1, child: Text('1- Lorem ipsum dolor sit amet')),
            //     const DropdownMenuItem(value: 2, child: Text('2- consectetur adipisici elit')),
            //     const DropdownMenuItem(value: 3, child: Text('3- sed eiusmod tempor incidunt')),
            //   ].toList(),
            //   labelText: 'Mein Dropdown',
            //   onChanged: (value) => setState(() => dropdownValue = value!),
            // ),
            // PicklisteTextField(
            //   enabled: active,
            //   labelText: 'Mein Textfeld',
            //   testKey: const ValueKey('playground-textfield'),
            //   controller: textEditingController,
            //   focusNode: focusNode,
            //   keyboardType: TextInputType.text,
            //   onFieldSubmitted: (value) => setState(() {}),
            // ),
          ],
        ),
      ),
    );
  }
}
