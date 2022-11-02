import 'package:flutter/material.dart';
import 'package:flutter_pickliste_widgets/flutter_pickliste_widgets.dart' hide ListDivided;
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/enums/testkey.dart';
import '../../../../core/extensions/list_divided.dart';
import '../../../../core/utils/translations.dart';
import '../../../diagnostics/domain/use_cases/get_house_number_url.dart';
import '../../../diagnostics/domain/use_cases/get_items.dart';
import '../../../flush/presentation/view/page.dart';
import '../../../form/presentation/view/page.dart';

class PalPage extends StatelessWidget {
  static const routeName = '/pal';
  static const diagnosticsRouteName = 'diagnostics';

  const PalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey(Testkey.pal_page.toString()),
      appBar: AppBar(title: const Text('PAL Show Cases')),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ListTile(
              key: ValueKey(Testkey.pal_menuFlushForm.toString()),
              title: const Text('Flush-Form'),
              leading: const Icon(Icons.slideshow),
              trailing: const Icon(Icons.navigate_next),
              onTap: () => context.push('$routeName/${FlushPage.routeName}'),
            ),
            ListTile(
              key: ValueKey(Testkey.pal_menuFormElements.toString()),
              title: const Text('Formular Elemente'),
              leading: const Icon(Icons.slideshow),
              trailing: const Icon(Icons.navigate_next),
              onTap: () => context.push('$routeName/${FormPage.routeName}'),
            ),
            // *** WIP ***
            // ListTile(
            //   key: ValueKey(Testkey.pal_menuToast.toString()),
            //   title: const Text('Toast'),
            //   leading: const Icon(Icons.slideshow),
            //   trailing: const Icon(Icons.navigate_next),
            //   onTap: () => context.push('$routeName/${ToastPage.routeName}'),
            // ),
            ListTile(
              key: ValueKey(Testkey.pal_menuDiagnostics.toString()),
              title: Text(T()().menu__app_settings_diagnostics),
              leading: const Icon(Icons.slideshow),
              trailing: const Icon(Icons.navigate_next),
              onTap: () {
                final di = GetIt.instance;
                final getItems = DiagnosticsUseCaseGetItems(di(), di(), di());
                final getHouseNumberURL = DiagnosticsUseCaseGetHouseNumberURL();
                final page = PicklisteDiagnosticsPage(
                  title: T()().menu__app_settings_diagnostics,
                  toastText: T()().general__please_wait,
                  infoText: T()().diagnostic__instructions,
                  items: getItems(),
                  houseNumberURL: getHouseNumberURL(withPic: true),
                );
                context.push('$routeName/${PalPage.diagnosticsRouteName}', extra: page);
              },
            ),
          ].toListDivided(),
        ),
      ),
    );
  }
}
