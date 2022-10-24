import 'package:flutter/material.dart';

import 'app.dart';

void main() {
  runApp(MyApp(key: UniqueKey(), isTestingEnvironment: true));
}

void startOrRestart() {
  main();
}
