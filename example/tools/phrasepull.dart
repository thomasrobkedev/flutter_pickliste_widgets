import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

void main() {
  PhrasePull().execute();
}

class PhrasePull {
  /// Public project id and read-only access token
  static const _accountID = 'ad15e351acba38f92c7e3b78283ca45e65d511834e975ebf72a579cbbe542398';
  static const _projectID = '5c4a6b51edeaccd231efa81a22c70bbe';

  /// Phrase locales
  static const _locales = ['de-DE', 'en-US', 'hr-HR', 'hu-HU', 'nl-NL', 'pl-PL', 'sk-SK', 'cs-CZ', 'bg-BG', 'sl-SI', 'ro-RO', 'sr-RS', 'lv-LV', 'lt-LT', 'et-EE'];

  bool hasErrors = false;

  Future<void> execute() async {
    for (var locale in _locales) {
      await _processLocale(locale);
    }

    stdout.writeln('Running flutter gen-l10n...');
    Process.run('flutter', ['gen-l10n'], runInShell: true, workingDirectory: 'example');

    stdout.writeln('Running flutter analyze...');
    Process.run('flutter', ['analyze'], runInShell: true, workingDirectory: 'example');

    exitCode = hasErrors ? 1 : 0;
  }

  Future<void> _processLocale(String locale) async {
    // Without the delay -> HTTP-429 "Too Many Requests"
    await Future.delayed(const Duration(milliseconds: 100));

    try {
      // Refactor into a flutter compatible format.
      final flutterCompatibleLocale = locale.split('-').first;

      // Fetch the .arb-File from Phrase
      final url = 'https://api.phrase.com/v2/projects/$_projectID/locales/$locale/download?access_token=$_accountID&file_format=arb';
      final contents = await read(Uri.parse(url));

      // PrettyPrint it into the project and correct the locale for flutter
      final Map<String, dynamic> json = const JsonDecoder().convert(contents);
      json['@@locale'] = flutterCompatibleLocale;
      final str = const JsonEncoder.withIndent('  ').convert(json);
      final path = 'example/lib/l10n/app_$flutterCompatibleLocale.arb';
      File(path).writeAsStringSync(str);

      stdout.writeln('$locale: success');
    } catch (e) {
      hasErrors = true;
      stderr.writeln('$locale: $e');
    }
  }
}
