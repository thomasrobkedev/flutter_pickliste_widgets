import 'package:dio/dio.dart';

class PicklisteUseCaseHttp {
  Future<String> call(
    String url, {
    int? connectTimeout = 5000,
    int? receiveTimeout = 10000,
  }) async {
    final dio = Dio(BaseOptions(connectTimeout: connectTimeout, receiveTimeout: receiveTimeout));
    final token = CancelToken();

    try {
      await dio.request(url, cancelToken: token);
      return '';
    } on DioError catch (e) {
      token.cancel();
      throw e.message;
    }
  }
}
