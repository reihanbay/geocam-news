import 'package:dio/dio.dart';

class ApiClient {
  late final Dio dio;

  ApiClient() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://newsapi.org/v2/',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Content-Type': 'application/json'}));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        print('[REQUEST] ${options.method} ${options.uri}');
        return handler.next(options); // continue
      },
      onResponse: (response, handler) {
        print(
            '[RESPONSE] ${response.statusCode} ${response.requestOptions.path}');
        return handler.next(response); // continue
      },
      onError: (DioException e, handler) {
        print('[ERROR] ${e.type} ${e.message}');
        return handler.next(e); // continue
      },
    ));
  }
}
