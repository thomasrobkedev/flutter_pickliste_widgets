import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class T {
  late final GlobalKey<ScaffoldMessengerState> _key;
  static final T _instance = T._internal();

  T._internal();

  factory T([key]) {
    if (key != null) {
      _instance._key = key;
    }
    return _instance;
  }

  AppLocalizations call() => AppLocalizations.of(_key.currentContext!)!;
}
