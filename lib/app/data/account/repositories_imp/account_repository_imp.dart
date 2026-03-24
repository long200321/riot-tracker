
import 'package:riot_tracker/app/data/account/mapper/account_mapper.dart';
import 'package:riot_tracker/app/data/account/request/get_summoner_request.dart';
import 'package:riot_tracker/app/data/account/request/login_request.dart';
import 'package:riot_tracker/app/data/account/services/get_summoner_service.dart';

import '../../../domain/account/entities/account.dart';
import '../../../domain/account/repositories/account_repository.dart';
import '../services/account_service.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountService service;
  final GetSummonerService summonerService;

  AccountRepositoryImpl(this.service, this.summonerService);

  @override
  Future<Account?> login(LoginRequest request) async {
    final response = await service.login(request);
    if (response != null) {
      return response.toEntity();
    }
  }

  @override
  Future<Account?> getUser(LoginRequest request) async {
    final response = await service.getUser(request);
    if (response != null) {
      return response.toEntity();
    }
  }

  @override
  Future<Account?> getSummoner(GetSummonerRequest request) async {
    final response = await summonerService.getSummoner(request);
    if (response != null) {
      return response.toEntity();
    }
  }

  @override
  Future<List<Rank>> getSummonerRank(GetSummonerRequest request) async {
    final responses = await summonerService.getSummonerRank(request);
    if (responses != null) {
      return responses.map((e) => e.toEntity()).toList();
    }
    return [];
  }

}