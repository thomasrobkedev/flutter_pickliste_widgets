import 'package:example/core/enums/testkey.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../functions.dart';

class Settings {
  void call() {
    testWidgets(description(this, ''), (tester) async {
      await startupApp(tester);

      await exists(Testkey.home_page);
      await tapAndExpect(Testkey.home_menuSettings, Testkey.settings_page);

      //................................
      // Wir checken die Theme
      //................................

      await tapAndExpect(Testkey.settings_menuTheme, Testkey.dropdown);

      await tapAndExpect(
        Testkey.dropdown_item.appendWithUnderscoreAndModifier(ThemeMode.dark, false),
        Testkey.settings_page,
      );
      await hasText('Dark');
      await tapAndExpect(Testkey.settings_menuTheme, Testkey.dropdown);
      await exists(
        Testkey.dropdown_item_icon.appendWithUnderscore(ThemeMode.dark),
      );
      await exists(
        Testkey.dropdown_item.appendWithUnderscoreAndModifier(ThemeMode.dark, true),
      );
      await exists(
        Testkey.dropdown_item.appendWithUnderscoreAndModifier(ThemeMode.light, false),
      );

      // reset zur initialen Darstellung (wichtig wenn das wieder gestestet werden soll)
      await tapAndExpect(
        Testkey.dropdown_item.appendWithUnderscoreAndModifier(ThemeMode.light, false),
        Testkey.settings_page,
      );
      await hasText('Light');

      //................................
      // Wir checken die Language
      //................................

      await tapAndExpect(Testkey.settings_menuLanguage, Testkey.dropdown);
      await tapAndExpect(
        Testkey.dropdown_item.appendWithUnderscoreAndModifier('sr', false),
        Testkey.settings_page,
      );
      await hasText('Serbisch');
      await tapAndExpect(Testkey.settings_menuLanguage, Testkey.dropdown);

      // wir setzen die Sprache auf English (wichtig wenn das wieder gestestet werden soll)
      await tapAndExpect(
        Testkey.dropdown_item.appendWithUnderscoreAndModifier('en', false),
        Testkey.settings_page,
      );
      await hasText('English');

      await goHome();
      await startupApp(tester);

      await hasText('Settings');
    });
  }
}
