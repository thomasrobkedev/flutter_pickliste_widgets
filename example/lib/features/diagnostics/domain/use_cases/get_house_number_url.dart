class DiagnosticsUseCaseGetHouseNumberURL {
  String call({required bool withPic}) {
    final pic = withPic ? '_pic' : '';
    return 'http://h471$pic.puc/pl07';
  }
}
