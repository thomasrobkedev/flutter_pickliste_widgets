import 'package:example/features/home/presentation/view/page.dart';
import 'package:example/main_test.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pickliste_widgets/flutter_pickliste_widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'config.dart';

part 'functions.dart';

// final scanner = ScannerEmulator();
// final printer = PrinterEmulator();

Future<void> main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

//   await Future.wait([scanner.start(), printer.start()]);

  tests.run();
}
