import 'package:flutter/cupertino.dart';
import 'package:flutter_pickliste_widgets/flutter_pickliste_widgets.dart';
import 'package:go_router/go_router.dart';

import '../../features/counter/presentation/view/page.dart';
import '../../features/diagnostics/domain/use_cases/get_house_number_url.dart';
import '../../features/diagnostics/domain/use_cases/get_items.dart';
import '../../features/flush/presentation/view/page.dart';
import '../../features/form/presentation/view/page.dart';
import '../../features/home/presentation/view/page.dart';
import '../utils/translations.dart';

final router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/',
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => CupertinoPage<void>(
        key: state.pageKey,
        child: const HomePage(),
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
      path: '/form-elements',
      pageBuilder: (context, state) => CupertinoPage<void>(
        key: state.pageKey,
        child: const FormPage(),
      ),
    ),
    GoRoute(
      path: '/flush-form',
      pageBuilder: (context, state) => CupertinoPage<void>(
        key: state.pageKey,
        child: const FlushPage(),
      ),
    ),
    GoRoute(
      path: '/diagnostics',
      pageBuilder: (context, state) {
        final getItems = DiagnosticsUseCaseGetItems();
        final getHouseNumberURL = DiagnosticsUseCaseGetHouseNumberURL();

        return CupertinoPage<void>(
          key: state.pageKey,
          child: PicklisteDiagnosticsPage(
            title: T()().menu__app_settings_diagnostics,
            toastText: T()().general__please_wait,
            infoText: T()().diagnostic__instructions,
            items: getItems(),
            houseNumberURL: getHouseNumberURL(withPic: true),
          ),
        );
      },
    ),
  ],
);
