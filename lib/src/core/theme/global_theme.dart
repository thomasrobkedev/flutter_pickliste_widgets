import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'theme_const.dart';

class PicklisteThemeCreator {
  static ThemeData create() {
    return ThemeData(
      fontFamily: 'Roboto',
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: const AppBarTheme(centerTitle: true, systemOverlayStyle: SystemUiOverlayStyle.light, toolbarHeight: 50),
      scaffoldBackgroundColor: const Color(PicklisteThemeConstants.kThemeBackgroundColor),
      dividerTheme: const DividerThemeData(space: 0, color: Color(PicklisteThemeConstants.kDividerColor), indent: 0, thickness: 0.5),
      primarySwatch: primarySwatch,
      textSelectionTheme: TextSelectionThemeData(selectionColor: const Color(PicklisteThemeConstants.kThemePrimaryColor).withOpacity(0.2)),
      textTheme: const TextTheme(
        headline1: TextStyle(fontSize: PicklisteThemeConstants.kFontSizeLarge, fontWeight: FontWeight.normal, color: Colors.white),
        caption: TextStyle(fontSize: PicklisteThemeConstants.kFontSizeMedium, color: Color(PicklisteThemeConstants.kTileTextColor), fontWeight: FontWeight.w300),
        bodyText1: TextStyle(fontSize: PicklisteThemeConstants.kFontSizeDefault),
        bodyText2: TextStyle(fontSize: PicklisteThemeConstants.kFontSizeDefault),
      ),
    );
  }

  static TextStyle blackText() {
    return const TextStyle(color: Colors.black);
  }

  static TextStyle get tableHeader {
    return const TextStyle(
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle get tableData {
    return const TextStyle(
      color: Color(PicklisteThemeConstants.kMonoSpaceColor),
      fontFamily: 'RobotoMono',
      fontSize: PicklisteThemeConstants.kFontSizeDefault - 1,
    );
  }

  static TextStyle get tableFooter {
    return PicklisteThemeCreator.tableData.copyWith(fontWeight: FontWeight.bold);
  }

  static TextStyle get logging {
    return const TextStyle(
      color: Color(PicklisteThemeConstants.kMonoSpaceColor),
      fontFamily: 'RobotoMono',
      fontSize: PicklisteThemeConstants.kFontSizeSmall - 2,
    );
  }

  static MaterialColor get primarySwatch {
    final r = const Color(PicklisteThemeConstants.kThemePrimaryColor).red;
    final g = const Color(PicklisteThemeConstants.kThemePrimaryColor).green;
    final b = const Color(PicklisteThemeConstants.kThemePrimaryColor).blue;

    return MaterialColor(
      PicklisteThemeConstants.kThemePrimaryColor,
      {50: -0.9, 100: -0.8, 200: -0.6, 300: -0.4, 400: -0.2, 500: 0, 600: 0.1, 700: 0.2, 800: 0.3, 900: 0.4}.map(
        (shade, shadeFactor) => MapEntry(
          shade,
          Color.fromRGBO(
            r - ((shade > 500 ? r : 255 - r) * shadeFactor).round(),
            g - ((shade > 500 ? g : 255 - g) * shadeFactor).round(),
            b - ((shade > 500 ? b : 255 - b) * shadeFactor).round(),
            1,
          ),
        ),
      ),
    );
  }
}
