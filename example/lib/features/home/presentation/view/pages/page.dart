import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/enums/testkey.dart';
import '../../../../../core/extensions/list_divided.dart';
import '../../../../../core/utils/translations.dart';
import '../../../../pal/presentation/view/pages/page.dart';
import '../../../../settings/presentation/view/pages/page.dart';

class HomePage extends StatelessWidget {
  static const counterRouteName = '/counter';

  const HomePage({super.key});

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
              onTap: () => context.push(counterRouteName),
            ),
            ListTile(
              key: ValueKey(Testkey.home_menuPAL.toString()),
              title: const Text('PAL + PLL'),
              leading: const Icon(Icons.slideshow),
              trailing: const Icon(Icons.navigate_next),
              onTap: () => context.push(PalPage.routeName),
            ),
            ListTile(
              key: ValueKey(Testkey.home_menuSettings.toString()),
              title: Text(T()().menu__settings),
              leading: const Icon(Icons.settings),
              trailing: const Icon(Icons.navigate_next),
              onTap: () => context.push(SettingsPage.routeName),
            ),
          ].toListDivided(),
        ),
      ),
    );
  }
}
