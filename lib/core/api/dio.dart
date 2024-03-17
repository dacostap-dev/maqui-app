import 'package:dio/dio.dart';

class Api {
  Api._internal();

  static Api? _api;
  final dio = createDio();

  static const _host = 'https://api.cambioseguro.com/api/v1.1/';

  String get getHost => _host;
  static const timeOut = Duration(seconds: 15);

  factory Api() => instance;

  static Api get instance {
    _api ??= Api._internal();
    return _api!;
  }

  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: _host,
        receiveTimeout: const Duration(seconds: 5),
        connectTimeout: const Duration(seconds: 5),
        sendTimeout: const Duration(seconds: 5),
        headers: {
          'accept': 'application/json',
          'content-type': 'application/json'
        },
      ),
    );

    dio.interceptors.addAll({
      CustomInterceptors(),
    });

    return dio;
  }
}

class CustomInterceptors extends Interceptor {
  CustomInterceptors();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    print(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    print('ERROR[${err.response?.statusCode}] => PATH: ${err.response?.data}');

    super.onError(err, handler);
  }
}
