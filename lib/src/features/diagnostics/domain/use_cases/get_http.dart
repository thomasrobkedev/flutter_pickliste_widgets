import 'package:dio/dio.dart';

class PicklisteDiagnosticsUseCaseGetHttp {
  Future<String> call(String url) async {
    final dio = Dio(BaseOptions(connectTimeout: 5000, receiveTimeout: 10000));
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
