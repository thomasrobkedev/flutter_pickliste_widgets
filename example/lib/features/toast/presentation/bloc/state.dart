import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../domain/models/data.dart';

@immutable
abstract class ToastState extends Equatable {
  @override
  List<Object> get props => [];
}

class ToastSubmit extends ToastState {
  final ToastData data;

  ToastSubmit(this.data);

  @override
  List<Object> get props => [...data.props, DateTime.now()];
}

class ToastPageRefresh extends ToastState {
  final ToastData data;

  ToastPageRefresh(this.data);

  @override
  List<Object> get props => [...data.props, DateTime.now()];
}
