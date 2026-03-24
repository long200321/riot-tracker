class GetSummonerRankResponse {
  final String queueType;
  final String tier;
  final String rank;
  final int leaguePoints;
  final int wins;
  final int losses;

  GetSummonerRankResponse({
    required this.queueType,
    required this.tier,
    required this.rank,
    required this.leaguePoints,
    required this.wins,
    required this.losses,
  });

  factory GetSummonerRankResponse.fromJson(Map<String, dynamic> json) {
    return GetSummonerRankResponse(
      queueType: json["queueType"] ?? "",
      tier: json["tier"] ?? "",
      rank: json["rank"] ?? "",
      leaguePoints: json["leaguePoints"] ?? 0,
      wins: json["wins"] ?? 0,
      losses: json["losses"] ?? 0,
    );
  }
}
