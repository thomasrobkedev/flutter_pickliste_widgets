import 'package:example/core/enums/testkey.dart';
import 'package:example/features/home/presentation/view/page.dart';
import 'package:example/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pickliste_widgets/flutter_pickliste_widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'tests/home.dart';

part '_classes/test.dart';
part 'config.dart';
part 'functions.dart';

// final scanner = ScannerEmulator();
// final printer = PrinterEmulator();

Future<void> main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

//   await Future.wait([scanner.start(), printer.start()]);

  tests.run();
}
