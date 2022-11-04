import 'package:equatable/equatable.dart';

class ToastData extends Equatable {
  final bool active;
  final bool startAnimation;
  final int animationDuration;
  final int autoTimeout;

  const ToastData({
    required this.active,
    required this.startAnimation,
    required this.animationDuration,
    required this.autoTimeout,
  });

  @override
  List<Object> get props => [active, startAnimation, animationDuration, autoTimeout];
}
