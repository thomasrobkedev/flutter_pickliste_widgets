import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app.dart';
import '../extensions/string.dart';

class AppTheme {
  ThemeData get light => _buildTheme(isLightMode: true);
  ThemeData get dark => _buildTheme(isLightMode: false);

  ThemeData _buildTheme({bool isLightMode = true}) {
    final base = isLightMode ? ThemeData.light() : ThemeData.dark();

    return base.copyWith(
      useMaterial3: true,
      appBarTheme: base.appBarTheme.copyWith(
        centerTitle: true,
        systemOverlayStyle: isLightMode ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
        backgroundColor: Colors.transparent,
        shape: Border(bottom: BorderSide(color: base.dividerColor)),
      ),
      pageTransitionsTheme: PageTransitionsTheme(
        builders: {for (var targetPlatform in TargetPlatform.values) targetPlatform: const CupertinoPageTransitionsBuilder()},
      ),
    );
  }

  String getBrightness(BuildContext context) {
    return MediaQuery.of(context).platformBrightness.name.ucFirst;
  }

  bool isLightMode(BuildContext context) {
    final name = MyApp.of(context).themeMode == ThemeMode.system ? MediaQuery.of(context).platformBrightness.name : MyApp.of(context).themeMode.name;
    return name == ThemeMode.light.name;
  }

  void setMode(BuildContext context, ThemeMode themeMode) {
    MyApp.of(context).themeMode = themeMode;
    _saveMode(themeMode);
  }

  Future<void> _saveMode(ThemeMode themeMode) async {
    (await SharedPreferences.getInstance()).setString('themeMode', themeMode.toString());
  }

  Future<ThemeMode> getSavedMode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeModeString = prefs.getString('themeMode');
      return ThemeMode.values.firstWhere((value) => value.toString() == themeModeString, orElse: () => ThemeMode.system);
    } catch (_) {
      return ThemeMode.system;
    }
  }
}
