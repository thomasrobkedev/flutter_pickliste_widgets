import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ToastState extends Equatable {
  @override
  List<Object> get props => [];
}

class ToastData extends ToastState {
  final bool active;
  final bool startAnimation;
  final int animationDuration;
  final int autoTimeout;
  final bool submitted;

  ToastData(
    this.active,
    this.startAnimation,
    this.animationDuration,
    this.autoTimeout,
    this.submitted,
  );

  @override
  List<Object> get props => [active, startAnimation, animationDuration, autoTimeout, submitted, DateTime.now()];
}
