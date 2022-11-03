abstract class ToastEvent {}

class ToastSubmit extends ToastEvent {
  final bool active;
  final bool startAnimation;
  final int animationDuration;
  final int autoTimeout;
  final bool submitted;

  ToastSubmit({
    required this.active,
    required this.startAnimation,
    required this.animationDuration,
    required this.autoTimeout,
    required this.submitted,
  });
}

class ToastReset extends ToastEvent {}
