import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pickliste_widgets/flutter_pickliste_widgets.dart';

import '../../../../../core/enums/testkey.dart';
import '../../../../../core/utils/translations.dart';
import '../../../domain/models/data.dart';
import '../../bloc/bloc.dart';
import '../../bloc/event.dart';
import '../../bloc/state.dart';

class ToastPage extends StatelessWidget {
  static const routeName = 'toast';

  ToastPage({super.key});
  final _bloc = ToastBloc();
  final _animationDurationController = TextEditingController();
  final _autoTimeoutController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocBuilder<ToastBloc, ToastState>(
        builder: (context, state) {
          return Scaffold(
            key: ValueKey(Testkey.toast_page.toString()),
            appBar: AppBar(title: const Text('Toast')),
            backgroundColor: const Color(PicklisteThemeCreator.kMenuBackgroundColor),
            body: _body(state),
          );
        },
      ),
    );
  }

  Widget _body(ToastState state) {
    if (state is ToastSubmit) {
      return PicklisteToast(
        key: ValueKey<String>(DateTime.now().toIso8601String()),
        textLarge: T()().general__please_wait,
        color: const Color.fromARGB(255, 255, 175, 0),
        active: state.data.active,
        startAnimation: state.data.startAnimation,
        animationDuration: state.data.animationDuration,
        autoTimeout: state.data.autoTimeout == 0 ? null : state.data.autoTimeout,
        testKey: ValueKey(Testkey.toast_toast.toString()),
        child: _content(state.data),
      );
    }

    if (state is ToastPageRefresh) {
      return _content(state.data);
    }

    return Container();
  }

  Widget _content(ToastData data) {
    _animationDurationController.text = data.animationDuration.toString();
    _autoTimeoutController.text = data.autoTimeout.toString();

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            PicklisteResponsiveRow(
              children: [
                PicklisteResponsiveCol(
                  md: 1,
                  child: PicklisteSwitch(
                    testKey: ValueKey(Testkey.toast_active.toString()),
                    title: 'Aktiv',
                    value: data.active,
                    onChanged: (value) => _bloc.add(ToastPageRefreshEvent(data, active: value!)),
                  ),
                ),
                PicklisteResponsiveCol(
                  md: 1,
                  child: PicklisteSwitch(
                    testKey: ValueKey(Testkey.toast_startAnimation.toString()),
                    title: 'Start-Animation',
                    value: data.startAnimation,
                    onChanged: (value) => _bloc.add(ToastPageRefreshEvent(data, startAnimation: value!)),
                  ),
                ),
                PicklisteResponsiveCol(
                  md: 1,
                  child: PicklisteTextField(
                    labelText: 'Animations-Dauer [ms]',
                    testKey: ValueKey(Testkey.toast_animationDuration.toString()),
                    controller: _animationDurationController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'\d{1,4}')),
                      LengthLimitingTextInputFormatter(4),
                    ],
                  ),
                ),
                PicklisteResponsiveCol(
                  md: 1,
                  child: PicklisteTextField(
                    labelText: 'Auto-Timeout [ms] (0 = deaktiviert)',
                    testKey: ValueKey(Testkey.toast_animationDuration.toString()),
                    controller: _autoTimeoutController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'\d{1,4}')),
                      LengthLimitingTextInputFormatter(4),
                    ],
                  ),
                ),
              ],
            ),
            PicklisteResponsiveRow(
              children: [
                PicklisteResponsiveCol(
                  sm: 1 / 2,
                  child: PicklisteTextButton(
                    testKey: ValueKey(Testkey.toast_submit.toString()),
                    caption: 'Submit',
                    primary: true,
                    onPressed: () => _bloc.add(
                      ToastSubmitEvent(
                        ToastData(
                          active: data.active,
                          startAnimation: data.startAnimation,
                          animationDuration: int.parse(_animationDurationController.text),
                          autoTimeout: int.parse(_autoTimeoutController.text),
                        ),
                      ),
                    ),
                  ),
                ),
                PicklisteResponsiveCol(
                  sm: 1 / 2,
                  child: PicklisteTextButton(
                    testKey: ValueKey(Testkey.toast_reset.toString()),
                    caption: 'Reset',
                    onPressed: () => _bloc.add(ToastResetEvent()),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
