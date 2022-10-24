import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class T {
  late final GlobalKey<ScaffoldMessengerState> _key;

  /// singleton
  static final T _instance = T._internal();
  T._internal();
  factory T() => _instance;

  void init(key) => _instance._key = key;

  /// [call()] ist die default Methode jedes Dart Objects - und somit auch jeder Dart Klasse.
  /// Darum sind die folgenden Aufrufe identisch [T().call()] = [T()()]
  AppLocalizations call() => AppLocalizations.of(_key.currentContext!)!;
}
