import '../../domain/models/data.dart';

abstract class ToastEvent {}

class ToastSubmitEvent extends ToastEvent {
  final ToastData data;

  ToastSubmitEvent(this.data);
}

class ToastPageRefreshEvent extends ToastEvent {
  final ToastData data;
  final bool? active;
  final bool? startAnimation;
  final int? animationDuration;
  final int? autoTimeout;

  ToastPageRefreshEvent(
    this.data, {
    this.active,
    this.startAnimation,
    this.animationDuration,
    this.autoTimeout,
  });
}

class ToastResetEvent extends ToastEvent {}
