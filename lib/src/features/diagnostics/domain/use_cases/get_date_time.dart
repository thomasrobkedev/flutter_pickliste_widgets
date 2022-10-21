class PicklisteDiagnosticsUseCaseGetDateTime {
  Future<String> call() async {
    final iso8601 = DateTime.now().toIso8601String().substring(0, 19).replaceAll('T', ' ');
    final match = RegExp(r'^(-)?(\d+)(?::00|(:\d+))').firstMatch(DateTime.now().timeZoneOffset.toString());
    final timezone = match == null ? '' : (match.group(1) ?? '+') + match.group(2).toString() + (match.group(3) ?? 'h');

    return Future.value('$iso8601 $timezone');
  }
}
