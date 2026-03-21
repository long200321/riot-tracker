import 'package:dio/dio.dart';
import 'package:riot_tracker/app/data/account/request/login_request.dart';
import 'package:riot_tracker/app/data/account/response/login_response.dart';

import '../../../core/network/api_client.dart';

class AccountService {
  final Dio _dio = ApiClient().dio;

  Future<LoginResponse?> login(LoginRequest request) async {
    try {
      final response = await _dio.get(request.toLoginPath());
      return LoginResponse.fromJson(response.data);
    } on DioException catch (e) {
      return null;
    }
  }
}