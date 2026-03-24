import 'package:riot_tracker/app/data/account/response/get_match_history_response.dart';
import 'package:riot_tracker/app/domain/account/entities/match_history.dart';

extension MatchHistoryMapper on GetMatchHistoryResponse {
  MatchHistory toEntity() {
    return MatchHistory(
      listMatch: listMatch ?? []
    );
  }
}

extension MatchMapper on MatchResponse {
  Match toEntity() {
    return Match(
      gameMode: info?.gameMode ?? "",
      participants: info?.participants
          ?.map((e) => e.toEntity())
          .toList() ??
          [],
    );
  }
}

extension ParticipantMapper on ParticipantResponse {
  Participant toEntity() {
    return Participant(
      championName: championName ?? "",
      puuid: puuid ?? "",
      kills: kills ?? 0,
      deaths: deaths ?? 0,
      assists: assists ?? 0,
      win: win ?? false,
      role: role ?? "",
      summonerSpell1: summoner1Id ?? 0,
      summonerSpell2: summoner2Id ?? 0,
      items: [
        item0 ?? 0,
        item1 ?? 0,
        item2 ?? 0,
        item3 ?? 0,
        item4 ?? 0,
        item5 ?? 0,
        item6 ?? 0,
      ],
    );
  }
}