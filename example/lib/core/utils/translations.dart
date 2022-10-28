import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app.dart';

class T {
  late final GlobalKey<ScaffoldMessengerState> _key;

  /// singleton
  static final T _instance = T._internal();
  T._internal();
  factory T() => _instance;

  void init(GlobalKey<ScaffoldMessengerState> key) => _instance._key = key;

  AppLocalizations call() => AppLocalizations.of(_key.currentContext!)!;

  void switchLanguage(BuildContext context, String? languageCode) {
    MyApp.of(context).setLocale(languageCode == null ? null : Locale.fromSubtags(languageCode: languageCode));
  }

  Future<Locale?> getSavedLocale() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final languageCode = prefs.getString('languageCode');
      return languageCode == 'null' ? null : Locale.fromSubtags(languageCode: languageCode!);
    } catch (_) {
      return null;
    }
  }

  Future<void> saveLocale(Locale? locale) async {
    (await SharedPreferences.getInstance()).setString('languageCode', locale?.languageCode ?? 'null');
  }

  String? get currentLanguageCode => MyApp.of(_key.currentContext!).locale?.languageCode;
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
