import 'package:flutter_bloc/flutter_bloc.dart';

import 'event.dart';
import 'state.dart';

class ToastBloc extends Bloc<ToastEvent, ToastState> {
  ToastBloc() : super(_resetState) {
    on<ToastSubmit>(_onSubmit);
    on<ToastReset>(_onReset);
  }

  void _onSubmit(ToastSubmit event, Emitter<ToastState> emit) {
    emit(
      ToastData(
        event.active,
        event.startAnimation,
        event.animationDuration,
        event.autoTimeout,
        event.submitted,
      ),
    );
  }

  void _onReset(ToastReset event, Emitter<ToastState> emit) {
    emit(_resetState);
  }

  static get _resetState => ToastData(true, true, 350, 2000, false);
}
