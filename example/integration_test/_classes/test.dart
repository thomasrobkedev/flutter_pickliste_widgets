// part of '../main_test.dart';

class Test {
  final int? _enabled;
  final Function() _func;

  Test(this._enabled, this._func);
}

class Group {
  final int? _enabled;
  final List<dynamic> _tests; // dynamic = Group|Test

  Group(this._enabled, this._tests);

  void run() {
    _execute(_enabled);
  }

  Future<void> _execute(int? enabled) async {
    for (var item in _tests) {
      if (item is Group) {
        item._execute(item._enabled ?? enabled);
        continue;
      }

      if (item is Test) {
        if ((item._enabled ?? enabled ?? 1) > 0) {
          try {
            await item._func();
          } catch (_) {
            // scanner.stop();
            // printer.stop();
          }
        }
      }
    }
  }
}
