import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';

import 'core/routing/router.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/environment.dart';
import 'core/utils/translations.dart';
import 'dependency_injection.dart';

class MyApp extends StatefulWidget {
  static GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  final bool isTestingEnvironment;

  MyApp({this.isTestingEnvironment = false, super.key}) {
    DependencyInjection().init();
    GetIt.I.get<Environment>().isTestingEnviroment = isTestingEnvironment;
  }

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) => context.findAncestorStateOfType<_MyAppState>()!;
  static const List<String> supportedLocales = ['de', 'en', 'hr', 'hu', 'nl', 'pl', 'sk', 'cs', 'bg', 'sl', 'ro', 'sr', 'lv', 'lt', 'et'];
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  Locale? get locale => _locale;
  setLocale(Locale? locale) {
    setState(() => _locale = locale);
    T().saveLocale(locale);
  }

  ThemeMode? _themeMode;
  ThemeMode get themeMode => _themeMode ?? ThemeMode.system;
  setThemeMode(ThemeMode themeMode) {
    setState(() => _themeMode = themeMode);
    AppTheme().saveMode(themeMode);
  }

  @override
  void initState() {
    T().getSavedLocale().then((locale) => setLocale(locale));
    AppTheme().getSavedMode().then((themeMode) => setThemeMode(themeMode));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme();

    return MaterialApp.router(
      title: 'Pickliste Flutter Widgets',
      theme: appTheme.light,
      darkTheme: appTheme.dark,
      themeMode: _themeMode ?? ThemeMode.system,
      routeInformationProvider: Routing.router.routeInformationProvider,
      routeInformationParser: Routing.router.routeInformationParser,
      routerDelegate: Routing.router.routerDelegate,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      scaffoldMessengerKey: MyApp.scaffoldMessengerKey,
      supportedLocales: MyApp.supportedLocales.map((languageCode) => Locale(languageCode)),
      locale: widget.isTestingEnvironment ? const Locale('de') : _locale,
    );
  }
}
