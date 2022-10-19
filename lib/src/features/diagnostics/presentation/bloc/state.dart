part of 'bloc.dart';

enum _Status { initializing, initialized, finished }

class PicklisteDiagnosticsState {
  final _Status status;
  final PicklisteDiagnosticsItems items;

  PicklisteDiagnosticsState([
    this.status = _Status.initializing,
    PicklisteDiagnosticsItems? items,
  ]) : items = items ?? PicklisteDiagnosticsItems();

  PicklisteDiagnosticsState copyWith({
    _Status? status,
    PicklisteDiagnosticsItems? items,
  }) {
    return PicklisteDiagnosticsState(
      status ?? this.status,
      items ?? this.items,
    );
  }

  bool get isLoading => status == _Status.initializing;
  bool get isFinished => status == _Status.finished;
}
