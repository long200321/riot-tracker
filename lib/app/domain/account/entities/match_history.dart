class MatchHistory {
  final List<String>? listMatch;
  MatchHistory({required this.listMatch});
}
class Match {
  final String gameMode;
  final List<Participant> participants;

  Match({
    required this.gameMode,
    required this.participants,
  });
}

class Participant {
  final String championName;
  final String puuid;
  final int kills;
  final int deaths;
  final int assists;
  final bool win;
  final String role;

  final List<int> items;
  final int summonerSpell1;
  final int summonerSpell2;

  Participant({
    required this.championName,
    required this.puuid,
    required this.kills,
    required this.deaths,
    required this.assists,
    required this.win,
    required this.role,
    required this.items,
    required this.summonerSpell1,
    required this.summonerSpell2,
  });

  static const Map<int, String> _spellMap = {
    1: "SummonerBoost",
    3: "SummonerExhaust",
    4: "SummonerFlash",
    6: "SummonerHaste",
    7: "SummonerHeal",
    11: "SummonerSmite",
    12: "SummonerTeleport",
    13: "SummonerMana",
    14: "SummonerDot",
    21: "SummonerBarrier",
    32: "SummonerSnowball",
  };

  String get summonerSpell1Name =>
      _spellMap[summonerSpell1] ?? "Unknown";

  String get summonerSpell2Name =>
      _spellMap[summonerSpell2] ?? "Unknown";
}