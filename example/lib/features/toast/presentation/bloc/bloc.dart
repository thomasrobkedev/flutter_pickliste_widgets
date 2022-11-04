import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/models/data.dart';
import 'event.dart';
import 'state.dart';

class ToastBloc extends Bloc<ToastEvent, ToastState> {
  ToastBloc() : super(_initialState) {
    on<ToastPageRefreshEvent>(_onPageRefresh);
    on<ToastSubmitEvent>(_onSubmit);
    on<ToastResetEvent>(_onReset);
  }

  void _onPageRefresh(ToastPageRefreshEvent event, Emitter<ToastState> emit) {
    emit(
      ToastPageRefresh(
        ToastData(
          active: event.active ?? event.data.active,
          startAnimation: event.startAnimation ?? event.data.startAnimation,
          animationDuration: event.animationDuration ?? event.data.animationDuration,
          autoTimeout: event.autoTimeout ?? event.data.autoTimeout,
        ),
      ),
    );
  }

  void _onSubmit(ToastSubmitEvent event, Emitter<ToastState> emit) {
    emit(ToastSubmit(event.data));
  }

  void _onReset(ToastResetEvent event, Emitter<ToastState> emit) {
    emit(_initialState);
  }

  static get _initialState => ToastPageRefresh(
        const ToastData(
          active: true,
          startAnimation: true,
          animationDuration: 350,
          autoTimeout: 3000,
        ),
      );
}
