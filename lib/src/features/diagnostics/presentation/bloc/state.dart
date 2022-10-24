import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../domain/models/items.dart';

@immutable
abstract class PicklisteDiagnosticsState extends Equatable {
  @override
  List<Object> get props => [];
}

class PicklisteDiagnosticsLoading extends PicklisteDiagnosticsState {}

class PicklisteDiagnosticsPending extends PicklisteDiagnosticsState {
  final PicklisteDiagnosticsItems items;

  PicklisteDiagnosticsPending(this.items);

  @override
  List<Object> get props => [items, DateTime.now()];
}

class PicklisteDiagnosticsFinished extends PicklisteDiagnosticsState {
  final PicklisteDiagnosticsItems items;

  PicklisteDiagnosticsFinished(this.items);
}
