import 'package:riot_tracker/app/data/account/response/get_summoner_response.dart';
import 'package:riot_tracker/app/data/account/response/login_response.dart';
import 'package:riot_tracker/app/domain/account/entities/account.dart';

import '../response/champion_mastery_response.dart';
import '../response/get_summoner_rank_response.dart';

extension AccountMapper on LoginResponse {
  Account toEntity() {
    return Account(
      puuid: puuid ?? "",
      gameName: gameName ?? "",
      tagLine: tagLine ?? "",
    );
  }
}

extension SummonerMapper on GetSummonerResponse {
  Account toEntity() {
    return Account(
      summonerLevel: summonerLevel,
      profileIconId: profileIconId
    );
  }
}

extension RankMapper on GetSummonerRankResponse {
  Rank toEntity() {
    return Rank(
      queueType: parseQueueType(queueType),
      tier: tier,
      rank: rank,
      leaguePoints: leaguePoints,
      wins: wins,
      losses: losses,
    );
  }
}

extension AccountMerge on Account {
  Account merge(Account other) {
    return Account(
      puuid: puuid ?? other.puuid,
      gameName: gameName ?? other.gameName,
      tagLine: tagLine ?? other.tagLine,
      profileIconId: profileIconId ?? other.profileIconId,
      summonerLevel: summonerLevel ?? other.summonerLevel,
      ranks: ranks ?? other.ranks
    );
  }
}

extension ChampionMasteryMapper on ChampionMasteryResponse {
  ChampionMastery toEntity() {
    return ChampionMastery(
      championId: championId,
      championName: championName,
      championLevel: championLevel,
      championPoints: championPoints,
      championPointsSinceLastLevel: championPointsSinceLastLevel,
      championPointsUntilNextLevel: championPointsUntilNextLevel,
    );
  }
}

