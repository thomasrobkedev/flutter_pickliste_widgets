import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../../app.dart';
import '../../../../core/enums/testkey.dart';
import '../../../../core/extensions/list_divided.dart';
import '../../../../core/extensions/string.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/translations.dart';
import '../../../flush/presentation/view/page.dart';
import '../../../form/presentation/view/page.dart';

class HomePage extends StatelessWidget {
  static const diagnosticsRouteName = '/diagnostics';
  static const languageRouteName = '/language';
  static const themeModeRouteName = '/theme-mode';

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
              onTap: () => context.push('/counter'),
            ),
            ListTile(
              key: ValueKey(Testkey.home_menuFlushForm.toString()),
              title: const Text('FlushForm'),
              leading: const Icon(Icons.slideshow),
              trailing: const Icon(Icons.navigate_next),
              onTap: () => context.push(FlushPage.routeName),
            ),
            ListTile(
              key: ValueKey(Testkey.home_menuFormElements.toString()),
              title: const Text('Formular Elemente'),
              leading: const Icon(Icons.slideshow),
              trailing: const Icon(Icons.navigate_next),
              onTap: () => context.push(FormPage.routeName),
            ),
            ListTile(
              key: ValueKey(Testkey.home_menuDiagnostics.toString()),
              title: Text(T()().menu__app_settings_diagnostics),
              leading: const Icon(Icons.query_stats),
              trailing: const Icon(Icons.navigate_next),
              onTap: () => context.push(HomePage.diagnosticsRouteName, extra: T()().menu__app_settings_diagnostics),
            ),
            ListTile(
              key: ValueKey(Testkey.home_menuLanguage.toString()),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(T()().settings__language),
                  Text(
                    T().currentLanguage + (T().currentLanguageCode == null ? ' (${Platform.localeName.substring(0, 2)})' : ''),
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              leading: const Icon(Icons.language),
              trailing: const Icon(Icons.navigate_next),
              onTap: () => context.push(HomePage.languageRouteName),
            ),
            ListTile(
              key: ValueKey(Testkey.home_menuTheme.toString()),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Theme'),
                  Text(
                    MyApp.of(context).themeMode.name.ucFirst + (MyApp.of(context).themeMode == ThemeMode.system ? ' (${AppTheme().getBrightness(context)})' : ''),
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              leading: const Icon(Icons.colorize),
              trailing: const Icon(Icons.navigate_next),
              onTap: () => context.push(HomePage.themeModeRouteName),
            ),
          ].toListDivided(),
        ),
      ),
    );
  }
}
