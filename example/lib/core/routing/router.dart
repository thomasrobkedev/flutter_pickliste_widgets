import 'package:flutter/material.dart';
import 'package:flutter_pickliste_widgets/flutter_pickliste_widgets.dart';
import 'package:go_router/go_router.dart';

import '../../features/counter/presentation/view/pages/page.dart';
import '../../features/flush/presentation/view/page.dart';
import '../../features/form/presentation/view/pages/page.dart';
import '../../features/home/presentation/view/pages/page.dart';
import '../../features/pal/presentation/view/pages/page.dart';
import '../../features/settings/presentation/view/pages/page.dart';
import '../../features/toast/presentation/view/pages/page.dart';

class Routing {
  static final router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/',
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (context, state) => HomePage(key: state.pageKey),
      ),
      GoRoute(
        path: HomePage.counterRouteName,
        builder: (context, state) => const CounterPage(title: 'Counter'),
      ),
      GoRoute(
        path: PalPage.routeName,
        builder: (context, state) => const PalPage(),
        routes: [
          GoRoute(
            path: FlushPage.routeName,
            builder: (context, state) => Theme(data: PicklisteThemeCreator.create(), child: const FlushPage()),
          ),
          GoRoute(
            path: FormPage.routeName,
            builder: (context, state) => Theme(data: PicklisteThemeCreator.create(), child: const FormPage()),
          ),
          GoRoute(
            path: ToastPage.routeName,
            builder: (context, state) => Theme(data: PicklisteThemeCreator.create(), child: ToastPage()),
          ),
          GoRoute(
            path: PalPage.diagnosticsRouteName,
            builder: (context, state) => Theme(data: PicklisteThemeCreator.create(), child: state.extra as Widget),
          ),
        ],
      ),
      GoRoute(
        path: SettingsPage.routeName,
        builder: (context, state) => SettingsPage(key: state.pageKey),
        routes: [
          GoRoute(
            path: SettingsPage.languageRouteName,
            pageBuilder: (context, state) => state.extra as Page,
          ),
          GoRoute(
            path: SettingsPage.themeModeRouteName,
            pageBuilder: (context, state) => state.extra as Page,
          ),
        ],
      ),
    ],
  );
}
