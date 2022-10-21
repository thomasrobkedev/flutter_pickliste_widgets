part of 'main_test.dart';

late WidgetTester tester;

/// Must be called at every start of testWidgets
Future<void> startupApp(WidgetTester activeTester) async {
  tester = activeTester;

  app.startOrRestart();
  await tester.pumpAndSettle();
}

String header(dynamic instance, [String? suffix]) {
  return '\n${'-' * 60}\n${instance.runtimeType.toString()}${suffix == null ? '' : ' / $suffix'}';
}

/// Requires the app to be in the main menu
Future<void> resetToBaseData() async {}

/// Requires the app to be in the main menu
Future<void> resetToAllData() async {}

/// tap + long press
/// --------------------------------------------------

Future<void> tap(dynamic testkey) async {
  await tester.ensureVisible(_find(testkey));
  await tester.tap(_find(testkey));
  await _waitForLoadingBarToGetInactive();
}

Future<void> tapAndExpect(dynamic tapTestkey, dynamic expectTestkey) async {
  await tap(tapTestkey);
  expect(find.byKey(ValueKey(_tts(expectTestkey))), findsWidgets);
}

Future<void> tapAndExpectText(dynamic tapTestkey, String expectText) async {
  await tap(tapTestkey);
  expect(find.textContaining(expectText), findsWidgets);
}

Future<void> tapOnText(String text) async {
  await tester.tap(find.widgetWithText(IndexedSemantics, text));
  await _waitForLoadingBarToGetInactive();
}

Future<void> tapOnScreenTopLeftCorner() async {
  await tester.tapAt(const Offset(10, 10));
  await tester.pumpAndSettle();
}

Future<void> longPress(dynamic longPressTestkey) async {
  await tester.longPress(find.byKey(ValueKey(_tts(longPressTestkey))));
  await _waitForLoadingBarToGetInactive();
}

Future<void> longPressAndExpect(dynamic longPressTestkey, dynamic expectTestkey) async {
  await longPress(longPressTestkey);
  expect(find.byKey(ValueKey(_tts(expectTestkey))), findsWidgets);
}

Future<void> longPressAndExpectText(dynamic longPressTestkey, String expectText) async {
  await longPress(longPressTestkey);
  expect(find.textContaining(expectText), findsWidgets);
}

/// text input
/// --------------------------------------------------

Future<void> enterText(dynamic inputTestkey, String inputText) async {
  await tester.enterText(find.byKey(ValueKey(_tts(inputTestkey))), inputText);
  await tester.pumpAndSettle();
}

Future<void> enterTextAndSubmit(dynamic inputTestkey, String inputText) async {
  await enterText(inputTestkey, inputText);
  await tester.testTextInput.receiveAction(TextInputAction.done);
  await _waitForLoadingBarToGetInactive();
}

Future<void> enterTextAndSubmitAndExpect(dynamic inputTestkey, String inputText, dynamic expectTestkey) async {
  await enterTextAndSubmit(inputTestkey, inputText);
  expect(find.byKey(ValueKey(_tts(expectTestkey))), findsWidgets);
}

Future<void> enterTextAndSubmitAndExpectText(dynamic inputTestkey, String inputText, String expectText) async {
  await enterTextAndSubmit(inputTestkey, inputText);
  expect(find.textContaining(expectText), findsWidgets);
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
  final w = tester.widget(find.byKey(ValueKey(_tts(inputTestkey))));

  if (w is TextFormField) {
    return expect(w.controller!.text, text);
  } else if (w is Text) {
    return expect(w.data, text);
  }

  throw Exception('Unknown type of text field');
}

Future<void> hintEqualsString(dynamic inputTestkey, String text) async {
  final w = tester.widget(find.byKey(ValueKey(_tts(inputTestkey))));

  if (w is PicklisteTextField) {
    return expect(w.hint, text);
  }

  throw Exception('Specified key doesnt point to AppFormTextField.'
      'Maybe you only passed it to "testKey" instead of "key"?'
      'Consider creating a seperate testkey.');
}

Future<void> checkObscuredPassword(dynamic inputTestkey, bool expectedResult) async {
  final passwordTextFormField = find.descendant(
    of: find.byKey(ValueKey(_tts(inputTestkey))),
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

Future<void> leavePageAndResetApp() async {
  await goHome();
  await resetToAllData();
}

Future<void> goHome() async {
  while (find.byType(BackButton).evaluate().isNotEmpty) {
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
  }

  expect(find.byType(HomePage), findsOneWidget);
}

/// util
/// --------------------------------------------------

/// Converts a Testkey or String into a String
String _tts(dynamic testkeyOrString) {
  return testkeyOrString is Testkey ? testkeyOrString.toString() : testkeyOrString;
}

Finder _find(dynamic testkeyOrString) {
  return find.byKey(ValueKey(testkeyOrString.toString()));
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

Future<void> _waitForLoadingBarToGetInactive() async {
  for (var i = 0; i < 5; i++) {
    await tester.pumpAndSettle(const Duration(milliseconds: 100));
  }
}

Future<String> getTextFromField(dynamic inputTestkey) async {
  final w = tester.widget(find.byKey(ValueKey(_tts(inputTestkey))));
  if (w is TextFormField) {
    return w.controller!.text;
  } else if (w is Text) {
    return (w.data.toString());
  }
  throw Exception('Unknown type of text field');
}
