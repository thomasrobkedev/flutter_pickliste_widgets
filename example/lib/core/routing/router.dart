import 'package:flutter/material.dart';
import 'package:flutter_pickliste_widgets/flutter_pickliste_widgets.dart';
import 'package:go_router/go_router.dart';

import '../../features/diagnostics/domain/use_cases/get_house_number_url.dart';
import '../../features/diagnostics/domain/use_cases/get_items.dart';
import '../../features/playground/presentation/view/page.dart';

final router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/playground',
  routes: <GoRoute>[
    GoRoute(
      path: '/playground',
      pageBuilder: (context, state) => _CupertinoTransitionPage<void>(
        key: state.pageKey,
        child: const PlaygroundPage(),
      ),
    ),
    GoRoute(
      path: '/diagnostics',
      pageBuilder: (context, state) => _CupertinoTransitionPage(
        key: state.pageKey,
        child: PicklisteDiagnosticsPage(
          items: DiagnosticsUseCaseGetItems().call(),
          houseNumberURL: DiagnosticsUseCaseGetHouseNumberURL().call(withPic: true),
        ),
      ),
    ),
  ],
);

class _CupertinoTransitionPage<T> extends CustomTransitionPage<T> {
  _CupertinoTransitionPage({
    super.key,
    required Widget child,
  }) : super(
          //   transitionDuration: const Duration(milliseconds: 200), // default: 300
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(animation),
              child: SlideTransition(
                position: Tween<Offset>(begin: Offset.zero, end: const Offset(-1, 0)).animate(secondaryAnimation),
                child: child,
              ),
            );
          },
          child: child,
        );
}
