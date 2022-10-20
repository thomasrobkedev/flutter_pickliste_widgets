import 'package:flutter/material.dart';
import 'package:flutter_pickliste_widgets/flutter_pickliste_widgets.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Pickliste Widgets'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ListTile(
              title: const Text('Flutter Demo'),
              leading: const FlutterLogo(),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/counter'),
            ),
            ListTile(
              title: const Text('FlushForm'),
              leading: const Icon(Icons.output),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/flush'),
            ),
            ListTile(
              title: const Text('Formular Elemente'),
              leading: const Icon(Icons.output),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/form'),
            ),
            ListTile(
              title: const Text('Diagnose'),
              leading: const Icon(Icons.query_stats),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/diagnostics'),
            ),
          ].toListDivided(withLastLine: true, indent: 16),
        ),
      ),
    );
  }
}
