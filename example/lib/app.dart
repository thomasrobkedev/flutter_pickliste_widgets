import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'core/routing/router.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/translations.dart';
import 'dependency_injection.dart';

class MyApp extends StatefulWidget {
  static GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  final bool isTestingEnvironment;

  MyApp({this.isTestingEnvironment = false, super.key}) {
    DependencyInjection().init();
  }

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) => context.findAncestorStateOfType<_MyAppState>()!;
  static const List<String> supportedLocales = ['de', 'en', 'hr', 'hu', 'nl', 'pl', 'sk', 'cs', 'bg', 'sl', 'ro', 'sr', 'lv', 'lt', 'et'];
}

class _MyAppState extends State<MyApp> {
  ThemeMode? _themeMode;
  ThemeMode get themeMode => _themeMode ?? ThemeMode.system;
  set themeMode(ThemeMode themeMode) => setState(() => _themeMode = themeMode);

  Locale? _locale;
  Locale? get locale => _locale;
  set locale(Locale? locale) => setState(() => _locale = locale);

  @override
  void initState() {
    AppTheme().getSavedMode().then((themeMode) => this.themeMode = themeMode);
    T().getSavedLocale().then((locale) => this.locale = locale);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme();

    if (_themeMode == null) {
      return const MaterialApp();
    }

    return MaterialApp.router(
      title: 'Pickliste Flutter Widgets',
      theme: appTheme.light,
      darkTheme: appTheme.dark,
      themeMode: themeMode,
      locale: locale,
      supportedLocales: MyApp.supportedLocales.map((languageCode) => Locale(languageCode)),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      routeInformationProvider: Routing.router.routeInformationProvider,
      routeInformationParser: Routing.router.routeInformationParser,
      routerDelegate: Routing.router.routerDelegate,
      scaffoldMessengerKey: MyApp.scaffoldMessengerKey,
    );
  }
}
