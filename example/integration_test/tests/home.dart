import 'package:example/core/enums/testkey.dart';
import 'package:flutter_test/flutter_test.dart';

import '../functions.dart';

class Home {
  void call() {
    testWidgets(description(this, ''), (tester) async {
      await startupApp(tester);

      await exists(Testkey.home_page);

      await goHome();
    });
  }
}
