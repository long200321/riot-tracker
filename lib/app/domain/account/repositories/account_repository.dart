import 'package:riot_tracker/app/data/account/request/get_summoner_request.dart';
import 'package:riot_tracker/app/data/account/request/login_request.dart';

import '../entities/account.dart';

abstract class AccountRepository {
  Future<Account?> login(LoginRequest request);
  Future<Account?> getUser(LoginRequest request);
  Future<Account?> getSummoner(GetSummonerRequest request);
  Future<List<Rank>> getSummonerRank(GetSummonerRequest request);
  Future<List<ChampionMastery>> getChampionMastery(GetSummonerRequest request);
}