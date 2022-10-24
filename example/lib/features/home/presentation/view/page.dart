import 'package:flutter/material.dart';
import 'package:flutter_pickliste_widgets/flutter_pickliste_widgets.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/enums/testkey.dart';
import '../../../../core/utils/translations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey(Testkey.home_page.toString()),
      appBar: AppBar(title: const Text('Flutter Pickliste Widgets')),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ListTile(
              title: const Text('Flutter Demo'),
              leading: const FlutterLogo(),
              trailing: const Icon(Icons.navigate_next),
              onTap: () => context.push('/counter'),
            ),
            ListTile(
              key: ValueKey(Testkey.home_menuFlushForm.toString()),
              title: const Text('FlushForm'),
              leading: const Icon(Icons.slideshow),
              trailing: const Icon(Icons.navigate_next),
              onTap: () => context.push('/flush-form'),
            ),
            ListTile(
              key: ValueKey(Testkey.home_menuFormElements.toString()),
              title: const Text('Formular Elemente'),
              leading: const Icon(Icons.slideshow),
              trailing: const Icon(Icons.navigate_next),
              onTap: () => context.push('/form-elements'),
            ),
            ListTile(
              key: ValueKey(Testkey.home_menuDiagnostics.toString()),
              title: Text(T()().menu__app_settings_diagnostics),
              leading: const Icon(Icons.query_stats),
              trailing: const Icon(Icons.navigate_next),
              onTap: () => context.push('/diagnostics'),
            ),
          ].toListDivided(withLastLine: true, indent: 16),
        ),
      ),
    );
  }
}
