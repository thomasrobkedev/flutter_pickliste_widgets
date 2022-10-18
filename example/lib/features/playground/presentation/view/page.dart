import 'package:flutter/material.dart';
import 'package:flutter_pickliste_widgets/flutter_pickliste_widgets.dart';
import 'package:go_router/go_router.dart';

class PlaygroundPage extends StatefulWidget {
  static const routeName = '/';

  const PlaygroundPage({super.key});

  @override
  State<PlaygroundPage> createState() => _PlaygroundPageState();
}

class _PlaygroundPageState extends State<PlaygroundPage> {
  bool playgroundEnabled = true;
  bool playgroundLoading = false;
  int playgroundDropdown = 1;
  final playgroundTextfield = TextEditingController();
  final playgroundTextfieldDanger = TextEditingController(text: 'DANGEROUS');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Playground'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const PicklisteToast(
              testKey: ValueKey('playground-toast'),
              textMedium: 'Bitte warten (3 sec)',
              color: Color.fromARGB(255, 255, 175, 0),
              active: true,
              autoTimeout: 3000,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  PicklisteTextButton(
                    testKey: const ValueKey('playground-textbutton-primary'),
                    caption: 'Diagnose',
                    primary: true,
                    onPressed: () => context.push('/diagnostics'),
                  ),
                  PicklisteTextButton(
                    testKey: const ValueKey('playground-textbutton-loading'),
                    caption: playgroundLoading ? 'Stop loading' : 'Start loading',
                    enabled: playgroundEnabled,
                    loading: playgroundLoading,
                    onPressed: () => setState(() {
                      playgroundLoading = !playgroundLoading;
                    }),
                  ),
                  PicklisteTextField(
                    enabled: playgroundEnabled,
                    labelText: 'Danger Textfeld',
                    testKey: const ValueKey('playground-textfield-danger'),
                    controller: playgroundTextfieldDanger,
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (value) => setState(() {}),
                  ),
                  PicklisteTextButton(
                    testKey: const ValueKey('playground-textbutton-danger'),
                    caption: 'Toggle danger text',
                    enabled: playgroundEnabled,
                    danger: true,
                    onPressed: () => setState(() {
                      playgroundTextfieldDanger.text = playgroundTextfieldDanger.text == 'DANGEROUS' ? 'not dangerous' : 'DANGEROUS';
                    }),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
