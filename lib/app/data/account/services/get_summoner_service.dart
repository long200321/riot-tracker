import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riot_tracker/app/data/account/request/get_summoner_request.dart';
import 'package:riot_tracker/app/data/account/response/get_summoner_rank_response.dart';
import 'package:riot_tracker/app/data/account/response/get_summoner_response.dart';

import '../../../core/network/api_client.dart';

class GetSummonerService {
  final Dio _dio = ApiClient(baseUrl: dotenv.env['BASE_SUMMONER_URL'] ?? "").dio;

  Future<GetSummonerResponse?> getSummoner(GetSummonerRequest request) async {
    try {
      final response = await _dio.get(request.toPath());
      return GetSummonerResponse.fromJson(response.data);
    } on DioException catch (e) {
      return null;
    }
  }

  Future<List<GetSummonerRankResponse>> getSummonerRank(GetSummonerRequest request) async {
    try {
      final response = await _dio.get(request.toGetRankPath());
      final data = response.data as List;
      return data.map((e) => GetSummonerRankResponse.fromJson(e)).toList();
    } on DioException catch (e) {
      return [];
    }
  }

}