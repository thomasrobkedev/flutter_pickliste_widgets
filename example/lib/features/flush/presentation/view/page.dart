import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pickliste_widgets/flutter_pickliste_widgets.dart';

import '../../../../core/utils/translations.dart';

class FlushPage extends StatefulWidget {
  static const routeName = 'flush-form';

  const FlushPage({super.key});

  @override
  State<FlushPage> createState() => _FlushPageState();
}

class _FlushPageState extends State<FlushPage> {
  final flushFormTextfield = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flush-Form')),
      backgroundColor: const Color(PicklisteThemeConstants.kMenuBackgroundColor),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              PicklisteTextButton(
                testKey: const ValueKey('flush-form-button-bool'),
                caption: '${T()().general__password} (bool)',
                onPressed: () async {
                  final result = await PicklisteFlushForm<bool>(
                    context: context,
                    introText: T()().general__please_enter_password,
                    labelText: T()().general__password,
                    okText: T()().general__ok,
                    cancelText: T()().general__cancel,
                    failText: T()().general__wrong_password,
                    password: true,
                    isValid: (String value) => value == 'test123',
                    getSuccessReturnValue: (String _) => true,
                    keyboardType: TextInputType.visiblePassword,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(16),
                    ],
                  ).show();

                  setState(() => flushFormTextfield.text = result == true ? 'valid' : '---');
                },
              ),
              PicklisteTextButton(
                testKey: const ValueKey('flush-form-button-string'),
                caption: '${T()().elbw_incoming__outgoing_number_short} (String)',
                onPressed: () async {
                  final result = await PicklisteFlushForm<String>(
                    context: context,
                    introText: T()().elbw_incoming__manual_input_of_outgoing_number,
                    labelText: T()().elbw_incoming__outgoing_number_short,
                    okText: T()().general__ok,
                    cancelText: T()().general__cancel,
                    failText: T()().elbw_incoming__manual_input_missmatch,
                    isValid: (String value) => value == '79',
                    getSuccessReturnValue: (String value) => value,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(7),
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                  ).show();

                  setState(() => flushFormTextfield.text = result ?? '---');
                },
              ),
              PicklisteTextField(
                enabled: false,
                labelText: 'Rückgabewert',
                testKey: const ValueKey('flush-form-return-value'),
                controller: flushFormTextfield,
                keyboardType: TextInputType.text,
                onFieldSubmitted: (value) => setState(() {}),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
