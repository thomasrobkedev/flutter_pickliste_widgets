import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_pickliste_widgets/flutter_pickliste_widgets.dart';
import 'package:get_it/get_it.dart';

import 'core/routing/router.dart';
import 'core/utils/environment.dart';
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
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp.router(
        title: 'Pickliste Flutter Widgets',
        theme: PicklisteThemeCreator.create(),
        routeInformationProvider: router.routeInformationProvider,
        routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        scaffoldMessengerKey: MyApp.scaffoldMessengerKey,
        supportedLocales: const [
          Locale('de', 'DE'),
          Locale('en', 'US'),
          Locale('hr', 'HR'),
          Locale('hu', 'HU'),
          Locale('nl', 'NL'),
          Locale('pl', 'PL'),
          Locale('sk', 'SK'),
          Locale('cs', 'CZ'),
          Locale('bg', 'BG'),
          Locale('sl', 'SI'),
          Locale('ro', 'RO'),
          //   const Locale('sr', 'RS'),  // keine Original Übersetzungen vorhanden
          Locale('lv', 'LV'),
          Locale('lt', 'LT'),
          //   const Locale('et', 'EE'),  // keine Original Übersetzungen vorhanden
        ],
        locale: widget.isTestingEnvironment ? const Locale('de', 'DE') : const Locale('de', 'DE'), // _locale,
      ),
    );
  }
}
