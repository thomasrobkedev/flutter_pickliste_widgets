import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  // Light Mode
//   final Color primaryColor = Colors.black;
//   final Color scaffoldColor = const Color(0xfff8f8f8);
//   final Color headlineColor = const Color(0xff333333);

  // Dark Mode
//   final Color primaryColorDark = Colors.white;
//   final Color scaffoldColorDark = const Color(0xff2a2a2a);
//   final Color headlineColorDark = const Color(0xffcdcdcd);

  ThemeData get light => _buildTheme(isLightMode: true);
  ThemeData get dark => _buildTheme(isLightMode: false);

  ThemeData _buildTheme({bool isLightMode = true}) {
    final base = isLightMode ? ThemeData.light() : ThemeData.dark();
    // final currentPrimaryColor = isLightMode ? primaryColor : primaryColorDark;
    // final currentHeadlineColor = isLightMode ? headlineColor : headlineColorDark;

    return base.copyWith(
      useMaterial3: true,
      appBarTheme: base.appBarTheme.copyWith(
        centerTitle: true,
        systemOverlayStyle: isLightMode ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
        backgroundColor: Colors.transparent,
        shape: Border(bottom: BorderSide(color: Colors.grey.withOpacity(.2))),
        // foregroundColor: currentPrimaryColor,
      ),
      //   primaryColor: currentPrimaryColor,
      //   scaffoldBackgroundColor: isLightMode ? scaffoldColor : scaffoldColorDark,
    );
  }
}
