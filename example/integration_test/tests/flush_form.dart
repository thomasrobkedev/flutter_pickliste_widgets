import 'package:example/core/enums/testkey.dart';
import 'package:example/core/utils/translations.dart';
import 'package:flutter_pickliste_widgets/flutter_pickliste_widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../functions.dart';

class FlushForm {
  void call() {
    testWidgets(description(this, ''), (tester) async {
      await startupApp(tester);

      await exists(Testkey.home_page);
      await tapAndExpect(Testkey.home_menuPAL, Testkey.pal_page);
      await tapAndExpect(Testkey.pal_menuFlushForm, Testkey.flushForm_page);

      /// --------------------------------------------------------------------------------------------------------------
      /// wir prüfen das Feld PicklisteFlushForm - Password.
      /// --------------------------------------------------------------------------------------------------------------

      // User klickt auf password button, dann klickt auf Abbrechen. Die Flushform verschwindet.
      // wir kommen auf vorherige Seite
      await tapAndExpect(Testkey.flushForm_buttonBool, PicklisteTestkey.flushForm);
      await tap(PicklisteTestkey.flushForm_cancel);
      await notExists(T()().general__please_enter_password);
      await equalsString(Testkey.flushForm_returnValue, '---');

      // User klickt auf Password button, User gibt falsche Password ein. Dann klickt auf OK
      // Ein Text "Falsches Passwort" wird ausgegeben
      await tapAndExpect(Testkey.flushForm_buttonBool, PicklisteTestkey.flushForm);
      await enterText(PicklisteTestkey.flushForm_input, 'test12');
      await tapAndExpectText(PicklisteTestkey.flushForm_ok, T()().general__wrong_password);
      await tap(PicklisteTestkey.flushForm_cancel); // um die flushForm zu verlassen
      await equalsString(Testkey.flushForm_returnValue, '---');

      // User klickt auf password button, User gibt falsches Password ein and submit
      // Ein Text "Falsches Passwort" wird ausgegeben
      await tapAndExpect(Testkey.flushForm_buttonBool, PicklisteTestkey.flushForm);
      await enterTextAndSubmitAndExpectText(PicklisteTestkey.flushForm_input, 'test12', T()().general__wrong_password);
      await tap(PicklisteTestkey.flushForm_cancel); // um die flushForm zu verlassen
      await equalsString(Testkey.flushForm_returnValue, '---');

      // User klickt auf password button, User gibt kein Password ein und Dann klickt auf OK.
      // Ein Text "Falsches Passwort" wird ausgegeben
      await tapAndExpect(Testkey.flushForm_buttonBool, PicklisteTestkey.flushForm);
      await tapAndExpectText(PicklisteTestkey.flushForm_ok, T()().general__wrong_password);
      await tap(PicklisteTestkey.flushForm_cancel); // um die flushForm zu verlassen
      await equalsString(Testkey.flushForm_returnValue, '---');

      // User klickt auf password button, User gibt richtiges Password ein and submit
      // Die Flushform verschwindet.
      await tapAndExpect(Testkey.flushForm_buttonBool, PicklisteTestkey.flushForm);
      await enterTextAndSubmit(PicklisteTestkey.flushForm_input, 'test123');
      await notExists(T()().general__please_enter_password);
      await equalsString(Testkey.flushForm_returnValue, 'valid');

      // User klickt auf password button, User gibt Password ein und klickt auf 'togglePasswordVisibility'
      // Der eingegebene Text sollte sichtbar sein (sichtbarkeit erkennbar)
      await tapAndExpect(Testkey.flushForm_buttonBool, PicklisteTestkey.flushForm);
      await enterTextAndSubmit(PicklisteTestkey.flushForm_input, 'test123valid');
      await checkObscuredPassword(PicklisteTestkey.flushForm_input, true);
      await tap(PicklisteTestkey.flushForm_input.append('_togglePasswordVisibility'));
      await checkObscuredPassword(PicklisteTestkey.flushForm_input, false);
      await tap(PicklisteTestkey.flushForm_cancel); // um die flushForm zu verlassen
      await equalsString(Testkey.flushForm_returnValue, '---');

      /// --------------------------------------------------------------------------------------------------------------
      /// wir prüfen das Feld PicklisteFlushForm - Product number.
      /// --------------------------------------------------------------------------------------------------------------

      // User klickt auf 'Product number' button, dann klickt auf Abbrechen. Die Flushform verschwindet.
      // wir kommen auf vorherige Seite
      await tapAndExpect(Testkey.flushForm_buttonString, PicklisteTestkey.flushForm);
      await hasText(T()().elbw_incoming__manual_input_of_outgoing_number);
      await tap(PicklisteTestkey.flushForm_cancel);
      await notExists(PicklisteTestkey.flushForm);
      await equalsString(Testkey.flushForm_returnValue, '---');

      // User klickt auf 'Product number' button, User gibt falsche Artikelnummer ein. Dann klickt auf OK
      // Ein Text "Manuelle Eingabe stimmt nicht mit Barcode überein." wird ausgegeben
      await tapAndExpect(Testkey.flushForm_buttonString, PicklisteTestkey.flushForm);
      await enterText(PicklisteTestkey.flushForm_input, '1234567');
      await tapAndExpectText(PicklisteTestkey.flushForm_ok, T()().elbw_incoming__manual_input_missmatch);
      await tap(PicklisteTestkey.flushForm_cancel); // um die flushForm zu verlassen
      await equalsString(Testkey.flushForm_returnValue, '---');

      // User klickt auf 'Product number' button, User gibt falsche Artikelnummer ein and submit
      // Ein Text "Manuelle Eingabe stimmt nicht mit Barcode überein." wird ausgegeben
      await tapAndExpect(Testkey.flushForm_buttonString, PicklisteTestkey.flushForm);
      await enterTextAndSubmitAndExpectText(PicklisteTestkey.flushForm_input, '1234567', T()().elbw_incoming__manual_input_missmatch);
      await tap(PicklisteTestkey.flushForm_cancel); // um die flushForm zu verlassen
      await equalsString(Testkey.flushForm_returnValue, '---');

      // User klickt auf 'Product number' button, User gibt keine Artikelnummer ein und Dann klickt auf OK.
      // Ein Text "Manuelle Eingabe stimmt nicht mit Barcode überein." wird ausgegeben
      await tapAndExpect(Testkey.flushForm_buttonString, PicklisteTestkey.flushForm);
      await tapAndExpectText(PicklisteTestkey.flushForm_ok, T()().elbw_incoming__manual_input_missmatch);
      await tap(PicklisteTestkey.flushForm_cancel); // um die flushForm zu verlassen
      await equalsString(Testkey.flushForm_returnValue, '---');

      // User klickt auf 'Product number' button, User gibt richtige Artikelnummer ein and submit.
      // Die Flushform verschwindet.
      await tapAndExpect(Testkey.flushForm_buttonString, PicklisteTestkey.flushForm);
      await hasText(T()().elbw_incoming__manual_input_of_outgoing_number);
      await enterTextAndSubmit(PicklisteTestkey.flushForm_input, '79');
      await notExists(PicklisteTestkey.flushForm);
      await equalsString(Testkey.flushForm_returnValue, '79');

      await goHome();
    });
  }
}
