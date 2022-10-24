import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'config.dart';

// final scanner = ScannerEmulator();
// final printer = PrinterEmulator();

Future<void> main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

//   await Future.wait([scanner.start(), printer.start()]);

  tests.run();
}
