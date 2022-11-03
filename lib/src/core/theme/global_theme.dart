import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PicklisteThemeCreator {
  static ThemeData create() {
    return ThemeData(
      fontFamily: 'Roboto',
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: const AppBarTheme(centerTitle: true, systemOverlayStyle: SystemUiOverlayStyle.light, toolbarHeight: 50),
      scaffoldBackgroundColor: const Color(kThemeBackgroundColor),
      dividerTheme: const DividerThemeData(space: 0, color: Color(kDividerColor), indent: 0, thickness: 0.5),
      primarySwatch: primarySwatch,
      textSelectionTheme: TextSelectionThemeData(selectionColor: const Color(kThemePrimaryColor).withOpacity(0.2)),
      textTheme: const TextTheme(
        headline1: TextStyle(fontSize: kFontSizeLarge, fontWeight: FontWeight.normal, color: Colors.white),
        caption: TextStyle(fontSize: kFontSizeMedium, color: Color(kTileTextColor), fontWeight: FontWeight.w300),
        bodyText1: TextStyle(fontSize: kFontSizeDefault),
        bodyText2: TextStyle(fontSize: kFontSizeDefault),
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
      color: Color(kMonoSpaceColor),
      fontFamily: 'RobotoMono',
      fontSize: kFontSizeDefault - 1,
    );
  }

  static TextStyle get tableFooter {
    return PicklisteThemeCreator.tableData.copyWith(fontWeight: FontWeight.bold);
  }

  static TextStyle get logging {
    return const TextStyle(
      color: Color(kMonoSpaceColor),
      fontFamily: 'RobotoMono',
      fontSize: kFontSizeSmall - 2,
    );
  }

  static MaterialColor get primarySwatch {
    final r = const Color(kThemePrimaryColor).red;
    final g = const Color(kThemePrimaryColor).green;
    final b = const Color(kThemePrimaryColor).blue;

    return MaterialColor(
      kThemePrimaryColor,
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

  // Application - Appearance
  static const int kThemePrimaryColor = 0xFF092D66;
  static const int kThemeBackgroundColor = 0xFFFFFFFF;
  static const int kMenuBackgroundColor = 0xFFE8E8E8;
  static const int kThemeAlertColor = 0xFFF44336;
  static const int kContainerBorderColor = 0xFFA0A0A0;
  static const int kDividerColor = 0xFFC0C0C0;
  static const int kLabelColor = 0xFF808080;
  static const int kLoadingSpinnerDisabled = 0xFF767676;

  // font sizes
  static const double kFontSizeSmall = 13;
  static const double kFontSizeDefault = 15;
  static const double kFontSizeMedium = 17;
  static const double kFontSizeLarge = 20;
  static const double kFontSizeExtraLarge = 26;

  // Tile - Appearance.
  static const int kTileBackgroundColor = 0xFFFFFFFF;
  static const int kTileDisabledBackgroundColor = 0xFFF1F1F1;
  static const int kTileIconColor = 0xE6092D66; // opacity 90%;
  static const int kTileIconColorDisabled = 0x33092D66; // opacity 20%;
  static const int kTileTextColor = 0xFF000000;
  static const int kTileBorderColor = 0xFFA0A0A0;
  static const int kTileBorderColorDisabled = 0xFFC0C0C0;
  static const int kTileDividerColor = 0xFFD0D0D0;
  static const int kMonoSpaceColor = 0xFF404040;
  static const double kTileBorderRadius = 8;
  static const double kTileIconSize = 36;
  static const double kTilePaddingAll = 8;
  static const double kTileMarginAll = 8;

  static const int kProgramAbsortieranweisung = 1;
  static const int kProgramDispoHz = 2;
  static const int kProgramRotpreiseAltware = 3;
  static const int kProgramRotpreiseVK = 4;
  static const int kProgramFehlteile = 5;
}
