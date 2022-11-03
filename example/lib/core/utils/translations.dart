import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app.dart';

class T {
  GlobalKey<ScaffoldMessengerState>? _key;

  /// singleton
  static final T _instance = T._internal();
  factory T() => _instance;
  T._internal();

  void init(GlobalKey<ScaffoldMessengerState> key) => _instance._key ??= key;
  AppLocalizations call() => AppLocalizations.of(_context)!;
  BuildContext get _context => _key!.currentContext!;

  void switchLanguage(BuildContext context, String? languageCode) {
    MyApp.of(context).locale = languageCode == null ? null : Locale.fromSubtags(languageCode: languageCode);
    _saveLanguageCode(languageCode);
  }

  Future<void> _saveLanguageCode(String? languageCode) async {
    (await SharedPreferences.getInstance()).setString('languageCode', languageCode ?? 'null');
  }

  Future<Locale?> getSavedLocale() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var languageCode = prefs.getString('languageCode');

      if (languageCode == null) {
        return null;
      }

      if (!MyApp.supportedLocales.contains(languageCode)) {
        languageCode = MyApp.supportedLocales.first;
        _saveLanguageCode(languageCode);
      }

      return Locale.fromSubtags(languageCode: languageCode);
    } catch (_) {
      return null;
    }
  }

  String? get currentLanguageCode => MyApp.of(_context).locale?.languageCode;
  String get currentLanguage => getLanguage(currentLanguageCode);

  String getLanguage(String? languageCode) {
    switch (languageCode) {
      case null:
        return call().settings__language_system;
      case 'de':
        return call().settings__language_german;
      case 'en':
        return call().settings__language_english;
      case 'hr':
        return call().settings__language_croatian;
      case 'hu':
        return call().settings__language_hungarian;
      case 'nl':
        return call().settings__language_dutch;
      case 'pl':
        return call().settings__language_polish;
      case 'sk':
        return call().settings__language_slovakian;
      case 'cs':
        return call().settings__language_czech;
      case 'bg':
        return call().settings__language_bulgarian;
      case 'sl':
        return call().settings__language_slovenian;
      case 'ro':
        return call().settings__language_romanian;
      case 'sr':
        return call().settings__language_serbian;
      case 'lv':
        return call().settings__language_latvian;
      case 'lt':
        return call().settings__language_lithuanian;
      case 'et':
        return call().settings__language_estonian;
    }

    return '';
  }
}
