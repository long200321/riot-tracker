import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiClient {
  late final Dio dio;

  ApiClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: dotenv.env['BASE_URL'] ?? '',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    _setupInterceptors();
  }

  void _setupInterceptors() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['X-Riot-Token'] =
          dotenv.env['RIOT_API_KEY'];

          return handler.next(options);
        },

        onError: (e, handler) {
          print('❌ ERROR: ${e.response?.statusCode}');
          print('❌ MESSAGE: ${e.response?.data}');
          return handler.next(e);
        },
      ),
    );
  }
}