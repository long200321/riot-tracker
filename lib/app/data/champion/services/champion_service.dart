import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riot_tracker/app/data/champion/request/champion_detail_request.dart';

import '../../../core/network/api_client.dart';
import '../response/list_champion_response.dart';

class ChampionService {
  final Dio _dio = ApiClient(
    baseUrl: dotenv.env['LIST_CHAMPION_URL'] ?? "",
  ).dio;

  Future<ListChampionResponse?> getChampions() async {
    try {
      final response = await _dio.get("/data/en_US/champion.json");

      return ListChampionResponse.fromJson(response.data);
    } on DioException catch (e) {
      print("❌ ERROR: ${e.response?.statusCode}");
      print("❌ MESSAGE: ${e.response?.data}");
      return null;
    }
  }

  Future<ChampionResponse?> getChampionDetail(
      ChampionDetailRequest request) async {
    try {
      final response = await _dio.get(request.toPath());
      final data = response.data['data'] as Map<String, dynamic>;
      final champJson = data.values.first;

      return ChampionResponse.fromJson(champJson);
    } on DioException catch (e) {
      print("❌ ERROR: ${e.response?.statusCode}");
      print("❌ MESSAGE: ${e.response?.data}");
      return null;
    }
  }
}