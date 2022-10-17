import 'package:flutter/material.dart';
import 'package:flutter_pickliste_widgets/flutter_pickliste_widgets.dart';

import 'features/diagnostics/domain/use_cases/get_house_number_url.dart';
import 'features/diagnostics/domain/use_cases/get_items.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PicklisteDiagnosticsPage(
        items: DiagnosticsUseCaseGetItems().call(),
        houseNumberURL: DiagnosticsUseCaseGetHouseNumberURL().call(withPic: true),
      ),
    );
  }
}
