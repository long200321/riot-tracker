import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riot_tracker/app/data/account/request/get_match_history_request.dart';
import 'package:riot_tracker/app/data/account/response/get_match_history_response.dart';

import '../../../core/network/api_client.dart';

class GetMatchHistoryService {
  final Dio _dio = ApiClient(baseUrl: dotenv.env['BASE_MATCH_HISTORY_URL'] ?? "").dio;

  Future<GetMatchHistoryResponse?> getListMatchHistory(GetMatchHistoryRequest request) async {
    try {
      final response = await _dio.get(request.toListMatch());
      return GetMatchHistoryResponse.fromJson(response.data);
    } on DioException catch (e) {
      return null;
    }
  }

  Future<MatchResponse?> getMatch(GetMatchHistoryRequest request) async {
    try {
      final response = await _dio.get(request.toMatch());
      return MatchResponse.fromJson(response.data);
    } on DioException catch (e) {
      return null;
    }
  }
}