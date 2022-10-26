import 'dart:async';

class DiagnosticsUseCaseGetHouseNumberURL {
  Future<String> call({required bool withPic}) async {
    final house = await _houseNumber();
    final pic = withPic ? '_pic' : '';
    return 'http://h$house$pic.puc/pl07';
  }

  /// HouseNumber ist in der MDE-App ein [String]. Im Launcher hingegen ein [Future<String>].
  /// Darum verlangt die Page ein Future. Das wird hier simluiert.
  Future<String> _houseNumber() async {
    return await Future.delayed(const Duration(milliseconds: 500), (() => '471'));
  }
}
