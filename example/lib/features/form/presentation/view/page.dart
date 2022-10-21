import 'package:flutter/material.dart';
import 'package:flutter_pickliste_widgets/flutter_pickliste_widgets.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  bool isEnabled = true;
  bool isLoading = false;
  int dropdownValue = 1;
  final textEditingController = TextEditingController();
  final focusNode = FocusNode();

  bool get isReset => isEnabled && !isLoading && dropdownValue == 1 && textEditingController.text == '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Playground')),
      backgroundColor: const Color(PicklisteThemeConstants.kMenuBackgroundColor),
      body: GestureDetector(
        onTap: (() {
          focusNode.unfocus();
          textEditingController.clear();
        }),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                PicklisteSwitch(
                  testKey: const ValueKey('playground-switch'),
                  title: 'Playground enabled/disabled',
                  value: isEnabled,
                  onChanged: (value) => setState(() => isEnabled = value!),
                ),
                PicklisteCheckbox(
                  testKey: const ValueKey('playground-checkbox'),
                  title: 'Playground enabled/disabled',
                  value: isEnabled,
                  onChanged: (value) => setState(() => isEnabled = value!),
                ),
                PicklisteTextButton(
                  testKey: const ValueKey('playground-textbutton-primary'),
                  caption: 'Reset Playground',
                  primary: true,
                  enabled: !isReset,
                  iconData: Icons.restore,
                  onPressed: () => setState(
                    () {
                      focusNode.unfocus();
                      textEditingController.clear();
                      isEnabled = true;
                      isLoading = false;
                      dropdownValue = 1;
                    },
                  ),
                ),
                PicklisteTextButton(
                  testKey: const ValueKey('playground-textbutton-danger'),
                  caption: 'Disable Playground',
                  enabled: isEnabled,
                  danger: true,
                  onPressed: () => setState(() => isEnabled = false),
                ),
                PicklisteTextButton(
                  enabled: isEnabled,
                  testKey: const ValueKey('playground-numberbutton'),
                  caption: 'Dummy',
                  number: 42,
                  onPressed: () => null,
                ),
                PicklisteTextButton(
                  testKey: const ValueKey('playground-textbutton-loading'),
                  caption: isLoading ? 'Stop loading' : 'Start loading',
                  enabled: isEnabled,
                  loading: isLoading,
                  onPressed: () => setState(() => isLoading = !isLoading),
                ),
                PicklisteDropdown<int>(
                  enabled: isEnabled,
                  testKey: const ValueKey('playground-dropdown'),
                  value: dropdownValue,
                  items: <DropdownMenuItem<int>>[
                    const DropdownMenuItem(value: 1, child: Text('1- Lorem ipsum dolor sit amet')),
                    const DropdownMenuItem(value: 2, child: Text('2- consectetur adipisici elit')),
                    const DropdownMenuItem(value: 3, child: Text('3- sed eiusmod tempor incidunt')),
                  ].toList(),
                  labelText: 'Mein Dropdown',
                  onChanged: (value) => setState(() => dropdownValue = value!),
                ),
                PicklisteTextField(
                  enabled: isEnabled,
                  labelText: 'Mein Textfeld',
                  testKey: const ValueKey('playground-textfield'),
                  controller: textEditingController,
                  focusNode: focusNode,
                  keyboardType: TextInputType.text,
                  onFieldSubmitted: (value) => setState(() {}),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
