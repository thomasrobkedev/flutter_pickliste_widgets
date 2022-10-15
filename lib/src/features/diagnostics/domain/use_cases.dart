import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

import '../data/repository.dart';
import '../presentation/bloc/bloc.dart';
import 'models/item.dart';
import 'models/items.dart';

class PicklisteDiagnosticsUseCases {
  final PicklisteDiagnosticsBloc bloc;
  final _repository = PicklisteDiagnosticsRepository();

  PicklisteDiagnosticsUseCases(this.bloc);

  PicklisteDiagnosticsItems get _items => _repository.fetchAll();
  PicklisteDiagnosticsItems getItems() => _items;

  void setItemsSync() {
    final iso8601 = DateTime.now().toIso8601String().substring(0, 19).replaceAll('T', ' ');
    final match = RegExp(r'^(-)?(\d+)(?::00|(:\d+))').firstMatch(DateTime.now().timeZoneOffset.toString());
    final timezone = match == null ? '' : (match.group(1) ?? '+') + match.group(2).toString() + (match.group(3) ?? 'h');

    _setSuccess(_items.dateTime, '$iso8601 $timezone');
  }

  void setItemsAsync() async {
    _addCallback(_items.versionBuild, _getVersionBuild());
    _addCallback(_items.houseDevice, _getHouseDevice());
    _addCallback(_items.mac, _getChannnelValue('utils', 'getMacAddress'));
    _addCallback(_items.serial, _getChannnelValue('device_identifiers', 'getSerialNumber'));
    _addCallback(_items.ip, NetworkInfo().getWifiIP());
    _addCallback(_items.wifiName, NetworkInfo().getWifiName());
    _addCallback(_items.dns1, _getChannnelValue('utils', 'getDNSServer1'));
    _addCallback(_items.dns2, _getChannnelValue('utils', 'getDNSServer2'));
    _addCallback(_items.defaultGateway, NetworkInfo().getWifiGatewayIP());
    _addCallback(_items.httpPuC, _http('http://www.peek-cloppenburg.de'));
    _addCallback(_items.httpHousePic, _http(await getHouseNumberURL(withPic: true)));
    _addCallback(_items.httpHouse, _http(await getHouseNumberURL(withPic: false)));
  }

  void updateItem(PicklisteDiagnosticsItem item, PicklisteDiagnosticsItemState state, String value) {
    _repository.updateItem(item, state: state, value: value);
  }

  void _setSuccess(PicklisteDiagnosticsItem item, String value) {
    _repository.updateItem(item, state: PicklisteDiagnosticsItemState.success, value: value);

    bloc.add(PicklisteDiagnosticsItemUpdated(item, PicklisteDiagnosticsItemState.success, value.toString()));
  }

  Future<void> _addCallback(PicklisteDiagnosticsItem item, Future<dynamic> callback) async {
    _repository.updateItem(item, state: PicklisteDiagnosticsItemState.pending);

    try {
      final value = await callback.timeout(const Duration(seconds: 10));
      bloc.add(PicklisteDiagnosticsItemUpdated(item, PicklisteDiagnosticsItemState.success, value.toString()));
    } catch (e) {
      bloc.add(PicklisteDiagnosticsItemUpdated(item, PicklisteDiagnosticsItemState.fail, e.toString()));
    }
  }

  bool get isFinished => _items.props.every((item) => item.state != PicklisteDiagnosticsItemState.pending);

  Future<String> _http(String url) async {
    final dio = Dio(BaseOptions(connectTimeout: 5000, receiveTimeout: 5000));
    final token = CancelToken();

    try {
      await dio.request(url, cancelToken: token);
      return '';
    } on DioError catch (e) {
      throw e.message;
    } finally {
      token.cancel();
    }
  }

  Future<String> getHouseNumberURL({required bool withPic}) async {
    final house = (await _getNumberFromFile('haus.dat')).padLeft(3, '0');
    final pic = withPic ? '_pic' : '';

    return 'http://h$house$pic.puc/pl07';
  }

  Future<String> _getVersionBuild() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return '${packageInfo.version}+${packageInfo.buildNumber}';
  }

  Future<String> _getHouseDevice() async {
    return '${await _getNumberFromFile('haus.dat')} / ${await _getNumberFromFile('geraet.dat')}';
  }

  Future<String> _getNumberFromFile(String filename) async {
    final file = File('${(await getApplicationSupportDirectory()).path}/pncshared/data/$filename');
    return (await file.readAsString(encoding: utf8)).trim();
  }

  Future<String> _getChannnelValue(String channel, String method) async {
    final match = RegExp(r'/(\w+(?:\.\w+)+)/files').firstMatch((await getApplicationSupportDirectory()).path);

    if (match != null) {
      final domainKey = match.group(1);
      return await MethodChannel('$domainKey/$channel').invokeMethod(method);
    }

    throw 'no value';
  }
}
