import 'package:flutter/cupertino.dart';
import 'package:flutter_pickliste_widgets/flutter_pickliste_widgets.dart';
import 'package:go_router/go_router.dart';

import '../../features/counter/presentation/view/page.dart';
import '../../features/diagnostics/domain/use_cases/get_house_number_url.dart';
import '../../features/diagnostics/domain/use_cases/get_items.dart';
import '../../features/home/presentation/view/page.dart';
import '../../features/playground/presentation/view/page.dart';

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
      path: '/playground',
      pageBuilder: (context, state) => CupertinoPage<void>(
        key: state.pageKey,
        child: const PlaygroundPage(),
      ),
    ),
    GoRoute(
      path: '/diagnostics',
      pageBuilder: (context, state) {
        // use cases (TODO: via injector rein reichen)
        final getItems = DiagnosticsUseCaseGetItems();
        final getHouseNumberURL = DiagnosticsUseCaseGetHouseNumberURL();

        return CupertinoPage<void>(
          key: state.pageKey,
          child: PicklisteDiagnosticsPage(
            getItems: () => getItems(),
            houseNumberURL: getHouseNumberURL(withPic: true),
          ),
        );
      },
    ),
  ],
);
