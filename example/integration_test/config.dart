import '_classes/test.dart';
import 'tests/diagnostics.dart';
import 'tests/flush_form.dart';
import 'tests/home.dart';
import 'tests/settings.dart';

typedef Root = Group;

///    1 = execute
///    0 = skip
/// null = inherit

final tests = Root(1, [
  Test(null, Home()),
  Test(null, FlushForm()),
  Test(null, Diagnostics()),
  Test(null, Settings()),
]);
