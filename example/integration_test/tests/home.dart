import 'package:example/core/enums/testkey.dart';
import 'package:flutter_test/flutter_test.dart';

import '../main_test.dart';

class Home {
  void call() {
    testWidgets(header(this), (tester) async {
      await startupApp(tester);

      await exists(Testkey.home_page);
      await tap(Testkey.home_menuCounter);

      await goHome();
    });
  }
}
