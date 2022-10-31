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
import '../../../../core/widgets/dropdown/dropdown.dart';
import '../../../../core/widgets/dropdown/item.dart';

class SettingsPage extends StatelessWidget {
  static const routeName = '/settings';
  static const languageRouteName = 'language';
  static const themeModeRouteName = 'theme-mode';

  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey(Testkey.settings_page.toString()),
      appBar: AppBar(title: Text(T()().menu__settings)),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ListTile(
              key: ValueKey(Testkey.settings_menuLanguage.toString()),
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
              onTap: () {
                context.push(
                  '$routeName/${SettingsPage.languageRouteName}',
                  extra: AppDropdown<String?>(
                    title: T()().settings__language,
                    callback: (languageCode) => T().switchLanguage(context, languageCode),
                    items: [
                      AppDropdownItem<String?>(
                        title: Text('${T().getLanguage(null)} (${Platform.localeName.substring(0, 2)})'),
                        value: null,
                        selected: T().currentLanguageCode == null,
                      ),
                      ...MyApp.supportedLocales.map(
                        (languageCode) => AppDropdownItem<String?>(
                          title: Text(T().getLanguage(languageCode)),
                          value: languageCode,
                          selected: T().currentLanguageCode == languageCode,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            ListTile(
              key: ValueKey(Testkey.settings_menuTheme.toString()),
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
              leading: Icon(AppTheme().isLightMode(context) ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
              trailing: const Icon(Icons.navigate_next),
              onTap: () => context.push(
                '$routeName/${SettingsPage.themeModeRouteName}',
                extra: AppDropdown<ThemeMode>(
                  title: 'Theme',
                  callback: (themeMode) => AppTheme().setMode(context, themeMode),
                  items: [ThemeMode.system, ThemeMode.light, ThemeMode.dark]
                      .map(
                        (themeMode) => AppDropdownItem<ThemeMode>(
                          title: Text(themeMode.name.ucFirst + (themeMode == ThemeMode.system ? ' (${AppTheme().getBrightness(context)})' : '')),
                          value: themeMode,
                          selected: MyApp.of(context).themeMode == themeMode,
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ].toListDivided(),
        ),
      ),
    );
  }
}
