import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pickliste_widgets/flutter_pickliste_widgets.dart';

import '../../../../../core/enums/testkey.dart';
import '../../../../../core/utils/translations.dart';
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

  Widget _body(ToastState toastState) {
    final state = toastState as ToastData;

    if (state.submitted) {
      return PicklisteToast(
        key: ValueKey<String>(DateTime.now().toIso8601String()),
        textLarge: T()().general__please_wait,
        color: const Color.fromARGB(255, 255, 175, 0),
        active: state.active,
        startAnimation: state.startAnimation,
        animationDuration: state.animationDuration,
        autoTimeout: state.autoTimeout == 0 ? null : state.autoTimeout,
        testKey: ValueKey(Testkey.toast_toast.toString()),
        child: _content(state),
      );
    }

    return _content(state);
  }

  void _pageRefresh(ToastData state, {bool? active, bool? startAnimation, int? animationDuration, int? autoTimeout}) {
    _bloc.add(
      ToastSubmit(
        active: active ?? state.active,
        startAnimation: startAnimation ?? state.startAnimation,
        animationDuration: animationDuration ?? state.animationDuration,
        autoTimeout: autoTimeout ?? state.autoTimeout,
        submitted: false,
      ),
    );
  }

  Widget _content(ToastData state) {
    _animationDurationController.text = state.animationDuration.toString();
    _autoTimeoutController.text = state.autoTimeout.toString();

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            PicklisteSwitch(
              testKey: ValueKey(Testkey.toast_active.toString()),
              title: 'active',
              value: state.active,
              onChanged: (value) => _pageRefresh(state, active: value!),
            ),
            PicklisteSwitch(
              testKey: ValueKey(Testkey.toast_startAnimation.toString()),
              title: 'Animation beim Start',
              value: state.startAnimation,
              onChanged: (value) => _pageRefresh(state, startAnimation: value!),
            ),
            PicklisteTextField(
              labelText: 'Animations-Dauer [ms]',
              testKey: ValueKey(Testkey.toast_animationDuration.toString()),
              controller: _animationDurationController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'\d{1,4}')),
                LengthLimitingTextInputFormatter(4),
              ],
            ),
            PicklisteTextField(
              labelText: 'Auto-Timeout [ms] (0 = deaktiviert)',
              testKey: ValueKey(Testkey.toast_animationDuration.toString()),
              controller: _autoTimeoutController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'\d{1,4}')),
                LengthLimitingTextInputFormatter(4),
              ],
            ),
            PicklisteTextButton(
              testKey: ValueKey(Testkey.toast_submit.toString()),
              caption: 'Submit',
              primary: true,
              onPressed: () => _bloc.add(
                ToastSubmit(
                  active: state.active,
                  startAnimation: state.startAnimation,
                  animationDuration: int.parse(_animationDurationController.text),
                  autoTimeout: int.parse(_autoTimeoutController.text),
                  submitted: true,
                ),
              ),
            ),
            PicklisteTextButton(
              testKey: ValueKey(Testkey.toast_reset.toString()),
              caption: 'Reset',
              onPressed: () => _bloc.add(ToastReset()),
            ),
          ],
        ),
      ),
    );
  }
}
