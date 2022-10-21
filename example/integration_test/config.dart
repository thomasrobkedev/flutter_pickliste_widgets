part of 'main_test.dart';

typedef Root = Group;

///    1 = execute
///    0 = skip
/// null = inherit

final tests = Root(1, [
  Test(null, Home()),
]);
