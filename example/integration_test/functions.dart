import 'package:example/features/home/presentation/view/pages/page.dart';
import 'package:example/main_test.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pickliste_widgets/flutter_pickliste_widgets.dart';
import 'package:flutter_test/flutter_test.dart';

late WidgetTester tester;

/// Must be called at every start of testWidgets
Future<void> startupApp(WidgetTester activeTester) async {
  tester = activeTester;

  app.startOrRestart();
  await tester.pumpAndSettle();

  /// Beim ersten build wird nur eine leere MaterialApp gerendert, denn wir warten noch auf [ThemeMode] und [Locale] aus async SharedPrefs.
  /// Wenn die Werte da sind, wird mittels [setState()] ein rebuild ausgelöst und die eigentliche MaterialApp geladen.
  /// Darum müssen wir insgesamt 2x pumpen.
  await tester.pumpAndSettle();
}

String description(dynamic instance, String text) {
  // ignore: prefer_interpolation_to_compose_strings
  return '\n' + ('_' * 60) + '\n' + instance.runtimeType.toString() + (text == '' ? '' : ' / $text') + '\n' + ('‾' * 60);
}

/// tap + long press
/// --------------------------------------------------

Future<void> tap(dynamic testkey) async {
  await tester.ensureVisible(_find(testkey));
  await tester.tap(_find(testkey));
  await tester.pumpAndSettle();
}

Future<void> tapAndExpect(dynamic tapTestkey, dynamic expectTestkey) async {
  await tap(tapTestkey);
  expect(_find(expectTestkey), findsWidgets);
}

Future<void> tapAndExpectText(dynamic tapTestkey, String expectText) async {
  await tap(tapTestkey);
  expect(_findText(expectText), findsWidgets);
}

Future<void> tapOnText(String text) async {
  await tester.tap(find.widgetWithText(IndexedSemantics, text));
  await tester.pumpAndSettle();
}

Future<void> tapOnScreenTopLeftCorner() async {
  await tester.tapAt(const Offset(10, 10));
  await tester.pumpAndSettle();
}

Future<void> longPress(dynamic longPressTestkey) async {
  await tester.longPress(_find(longPressTestkey));
  await tester.pumpAndSettle();
}

Future<void> longPressAndExpect(dynamic longPressTestkey, dynamic expectTestkey) async {
  await longPress(longPressTestkey);
  expect(_find(expectTestkey), findsWidgets);
}

Future<void> longPressAndExpectText(dynamic longPressTestkey, String expectText) async {
  await longPress(longPressTestkey);
  expect(_findText(expectText), findsWidgets);
}

/// text input
/// --------------------------------------------------

Future<void> enterText(dynamic inputTestkey, String inputText) async {
  await tester.enterText(_find(inputTestkey), inputText);
  await tester.pumpAndSettle();
}

Future<void> enterTextAndSubmit(dynamic inputTestkey, String inputText) async {
  await enterText(inputTestkey, inputText);
  await tester.testTextInput.receiveAction(TextInputAction.done);
  await tester.pumpAndSettle();
}

Future<void> enterTextAndSubmitAndExpect(dynamic inputTestkey, String inputText, dynamic expectTestkey) async {
  await enterTextAndSubmit(inputTestkey, inputText);
  expect(_find(expectTestkey), findsWidgets);
}

Future<void> enterTextAndSubmitAndExpectText(dynamic inputTestkey, String inputText, String expectText) async {
  await enterTextAndSubmit(inputTestkey, inputText);
  expect(_findText(expectText), findsWidgets);
}

Future<void> deleteText(dynamic inputTestkey, int characterCount) async {
  await tap(inputTestkey);
  for (var i = 1; i <= characterCount; i++) {
    await simulateKeyDownEvent(LogicalKeyboardKey.backspace);
    await tester.pumpAndSettle();
  }
}

/// test functions
/// --------------------------------------------------

Future<void> equalsString(dynamic inputTestkey, String text) async {
  final w = tester.widget(_find(inputTestkey).first);

  if (w is TextFormField) {
    return expect(w.controller!.text, text);
  } else if (w is Text) {
    return expect(w.data, text);
  }

  throw Exception('Unknown type of text field');
}

Future<void> hintEqualsString(dynamic inputTestkey, String text) async {
  final w = tester.widget(_find(inputTestkey));

  if (w is PicklisteTextField) {
    return expect(w.hint, text);
  }

  throw Exception('Specified key doesnt point to AppFormTextField.'
      'Maybe you only passed it to "testKey" instead of "key"?'
      'Consider creating a seperate testkey.');
}

Future<void> checkObscuredPassword(dynamic inputTestkey, bool expectedResult) async {
  final passwordTextFormField = find.descendant(
    of: _find(inputTestkey),
    matching: find.byType(EditableText),
  );
  final input = tester.widget<EditableText>(passwordTextFormField);
  expect(input.obscureText, expectedResult);
}

Future<void> equalsTrue(bool a) async {
  expect(a, true);
}

Future<void> equalsFalse(bool a) async {
  expect(a, false);
}

Future<void> hasText(String text) async {
  expect(find.text(text), findsWidgets);
}

Future<void> notHasText(String text) async {
  expect(find.text(text), findsNothing);
}

Future<void> exists(dynamic testkey) async {
  expect(_find(testkey), findsWidgets);
}

Future<void> notExists(dynamic testkey) async {
  expect(_find(testkey), findsNothing);
}

/// navigation
/// --------------------------------------------------
Future<void> goBack() async {
  await tester.tap(find.byType(BackButton));
  await tester.pumpAndSettle();
}

Future<void> goHome() async {
  while (find.byType(BackButton).evaluate().isNotEmpty) {
    await goBack();
  }

  expect(find.byType(HomePage), findsOneWidget);
}

/// util
/// --------------------------------------------------

Finder _find(dynamic testkey) {
  return find.byKey(ValueKey(testkey.toString()));
}

Finder _findText(Pattern expectText) {
  return find.textContaining(expectText);
}

Future<void> wait(int seconds) async {
  await Future.delayed(Duration(seconds: seconds));
  await tester.pumpAndSettle();
}

Future<void> hold() async {
  await Future.delayed(const Duration(seconds: 300));
}

Future<void> scroll(dynamic testkey, double delta) async {
  await tester.scrollUntilVisible(_find(testkey), delta, scrollable: find.byType(Scrollable).first);
  await tester.pumpAndSettle();
}

Future<String> getTextFromField(dynamic inputTestkey) async {
  final w = tester.widget(_find(inputTestkey));
  if (w is TextFormField) {
    return w.controller!.text;
  } else if (w is Text) {
    return (w.data.toString());
  }
  throw Exception('Unknown type of text field');
}
