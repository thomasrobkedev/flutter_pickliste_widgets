import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pickliste_widgets/flutter_pickliste_widgets.dart';

import '../../../../core/extensions/build_context.dart';

class FlushPage extends StatefulWidget {
  const FlushPage({super.key});

  @override
  State<FlushPage> createState() => _FlushPageState();
}

class _FlushPageState extends State<FlushPage> {
  final textEditingController = TextEditingController();
  bool passwordValid = false;
  String outgoingNumber = '';

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
                caption: 'Passwort (bool)',
                icon: passwordValid ? const Icon(Icons.check, color: Colors.green, size: 24) : null,
                onPressed: () async {
                  final result = await PicklisteFlushForm<bool>(
                    context: context,
                    introText: context.loc.general__please_enter_password,
                    labelText: context.loc.general__password,
                    okText: context.loc.general__ok,
                    cancelText: context.loc.general__cancel,
                    failText: context.loc.general__wrong_password,
                    password: true,
                    isValid: (String value) => value == 'dev',
                    getSuccessReturnValue: (String _) => true,
                    keyboardType: TextInputType.visiblePassword,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(16),
                    ],
                  ).show();

                  if (result != null) {
                    setState(() => passwordValid = true);
                  }
                },
              ),
              PicklisteTextButton(
                testKey: const ValueKey('flush-form-button-string'),
                caption: 'Artikelnummer (String)',
                number: outgoingNumber,
                onPressed: () async {
                  final result = await PicklisteFlushForm<String>(
                    context: context,
                    introText: context.loc.elbw_incoming__manual_input_of_outgoing_number,
                    labelText: context.loc.elbw_incoming__outgoing_number_short,
                    okText: context.loc.general__ok,
                    cancelText: context.loc.general__cancel,
                    failText: context.loc.elbw_incoming__manual_input_missmatch,
                    isValid: (String _) => true,
                    getSuccessReturnValue: (String value) => value,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(7),
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                  ).show();

                  if (result != null) {
                    setState(() => outgoingNumber = result);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}