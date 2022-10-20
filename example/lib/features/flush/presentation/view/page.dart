import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pickliste_widgets/flutter_pickliste_widgets.dart';

class FlushPage extends StatefulWidget {
  const FlushPage({super.key});

  @override
  State<FlushPage> createState() => _FlushPageState();
}

class _FlushPageState extends State<FlushPage> {
  final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flush-Form')),
      backgroundColor: const Color(kMenuBackgroundColor),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              PicklisteTextButton(
                testKey: const ValueKey('flush-form-button-bool'),
                caption: 'Passwort (bool)',
                onPressed: () async {
                  final result = await PicklisteFlushForm<bool>(
                    context: context,
                    introText: 'Bitte Passwort eingeben', // AppLocalizations.of(context)!.general__please_enter_password,
                    labelText: 'Passwort', // AppLocalizations.of(context)!.general__password,
                    password: true,
                    isValid: (String value) => value == 'dev',
                    getSuccessReturnValue: (String _) => true,
                    keyboardType: TextInputType.visiblePassword,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(16),
                    ],
                  ).show();
                  setState(() => textEditingController.text = result == true ? 'valid' : '---');
                },
              ),
              PicklisteTextButton(
                testKey: const ValueKey('flush-form-button-string'),
                caption: 'Artikelnummer (String)',
                onPressed: () async {
                  final result = await PicklisteFlushForm<String>(
                    context: context,
                    introText: 'Bitte Artikelnummer eingeben',
                    labelText: 'Artikelnummer', // AppLocalizations.of(context)!.general__product_number,
                    isValid: (String value) => value == '79',
                    getSuccessReturnValue: (String value) => value,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(7),
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                  ).show();
                  setState(() => textEditingController.text = result ?? '---');
                },
              ),
              PicklisteTextField(
                enabled: false,
                labelText: 'Rückgabewert',
                testKey: const ValueKey('flush-form-return-value'),
                controller: textEditingController,
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
