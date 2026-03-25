import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riot_tracker/app/data/account/request/get_summoner_request.dart';
import 'package:riot_tracker/app/data/account/response/champion_mastery_response.dart';
import 'package:riot_tracker/app/data/account/response/get_summoner_rank_response.dart';
import 'package:riot_tracker/app/data/account/response/get_summoner_response.dart';

import '../../../core/network/api_client.dart';

class GetSummonerService {
  final Dio _dio = ApiClient(baseUrl: dotenv.env['BASE_SUMMONER_URL'] ?? "").dio;
  Map<String, dynamic>? _championsData;

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

  Future<void> _loadChampionsData() async {
    if (_championsData != null) return;
    final String championsJsonString =
    await rootBundle.loadString('assets/champion/champion.json');
    _championsData = json.decode(championsJsonString)['data'];
  }

  Future<List<ChampionMasteryResponse>> getChampionMastery(GetSummonerRequest request) async {
    try {
      await _loadChampionsData();
      final response = await _dio.get(request.toChampionMasteryPath());
      final data = response.data as List;
      return data
          .map((e) => ChampionMasteryResponse.fromJson(e, _championsData ?? {}))
          .toList();
    } on DioException catch (e) {
      return [];
    }
  }

}