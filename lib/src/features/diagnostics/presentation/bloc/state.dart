part of 'bloc.dart';

enum _Status { initializing, initialized, finished }

class PicklisteDiagnosticsState {
  final _Status status;
  final PicklisteDiagnosticsItems items;
  final String houseNumberURL;

  PicklisteDiagnosticsState([
    this.status = _Status.initializing,
    PicklisteDiagnosticsItems? items,
    this.houseNumberURL = '',
  ]) : items = items ?? PicklisteDiagnosticsItems();

  PicklisteDiagnosticsState copyWith({
    _Status? status,
    PicklisteDiagnosticsItems? items,
    String? houseNumberURL,
  }) {
    return PicklisteDiagnosticsState(
      status ?? this.status,
      items ?? this.items,
      houseNumberURL ?? this.houseNumberURL,
    );
  }

  bool get isLoading => status == _Status.initializing;
  bool get isFinished => status == _Status.finished;
}
