import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pickliste_widgets/flutter_pickliste_widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../app.dart';
import '../../features/counter/presentation/view/page.dart';
import '../../features/diagnostics/domain/use_cases/get_house_number_url.dart';
import '../../features/diagnostics/domain/use_cases/get_items.dart';
import '../../features/flush/presentation/view/page.dart';
import '../../features/form/presentation/view/page.dart';
import '../../features/home/presentation/view/page.dart';
import '../extensions/string.dart';
import '../utils/translations.dart';
import '../widgets/dropdown/dropdown.dart';
import '../widgets/dropdown/item.dart';

class Routing {
  static final router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/',
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => CupertinoPage<void>(
          key: state.pageKey,
          child: HomePage(
            key: UniqueKey(),
          ),
        ),
      ),
      GoRoute(
        path: '/counter',
        pageBuilder: (context, state) => CupertinoPage<void>(
          key: state.pageKey,
          child: const CounterPage(title: 'Counter'),
        ),
      ),
      GoRoute(
        path: FormPage.routeName,
        pageBuilder: (context, state) => CupertinoPage<void>(
          key: state.pageKey,
          child: Theme(data: PicklisteThemeCreator.create(), child: const FormPage()),
        ),
      ),
      GoRoute(
        path: FlushPage.routeName,
        pageBuilder: (context, state) => CupertinoPage<void>(
          key: state.pageKey,
          child: Theme(data: PicklisteThemeCreator.create(), child: const FlushPage()),
        ),
      ),
      GoRoute(
        path: HomePage.diagnosticsRouteName,
        pageBuilder: (context, state) {
          final di = GetIt.instance;
          final getItems = DiagnosticsUseCaseGetItems(di(), di(), di());
          final getHouseNumberURL = DiagnosticsUseCaseGetHouseNumberURL();

          return CupertinoPage<void>(
            key: state.pageKey,
            child: Theme(
              data: PicklisteThemeCreator.create(),
              child: PicklisteDiagnosticsPage(
                title: T()().menu__app_settings_diagnostics,
                toastText: T()().general__please_wait,
                infoText: T()().diagnostic__instructions,
                items: getItems(),
                houseNumberURL: getHouseNumberURL(withPic: true),
              ),
            ),
          );
        },
      ),
      GoRoute(
        path: HomePage.languageRouteName,
        pageBuilder: (context, state) {
          return CupertinoPage<void>(
            fullscreenDialog: true,
            child: Dropdown<String?>(
              title: T()().settings__language,
              callback: (languageCode) => T().switchLanguage(context, languageCode),
              items: [
                DropdownItem<String?>(title: Text(T().getLanguage(null)), value: null, selected: T().languageCode == null),
                ...MyApp.supportedLocales.map(
                  (languageCode) => DropdownItem<String?>(
                    title: Text(T().getLanguage(languageCode)),
                    value: languageCode,
                    selected: T().languageCode == languageCode,
                    enabled: !['sr', 'et'].contains(languageCode),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      GoRoute(
        path: HomePage.themeModeRouteName,
        pageBuilder: (context, state) {
          return CupertinoPage<void>(
            fullscreenDialog: true,
            child: Dropdown<ThemeMode>(
              title: T()().settings__language,
              callback: (themeMode) => MyApp.of(context).themeMode = themeMode,
              items: [ThemeMode.system, ThemeMode.light, ThemeMode.dark]
                  .map(
                    (themeMode) => DropdownItem<ThemeMode>(
                      title: Text(themeMode.name.ucFirst),
                      value: themeMode,
                      selected: MyApp.of(context).themeMode == themeMode,
                    ),
                  )
                  .toList(),
            ),
          );
        },
      ),
    ],
  );
}
