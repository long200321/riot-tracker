class GetSummonerResponse {
  final int profileIconId;

  GetSummonerResponse({required this.profileIconId, required this.summonerLevel});

  final int summonerLevel;
  factory GetSummonerResponse.fromJson(Map<String, dynamic> json) {
    return GetSummonerResponse(
      profileIconId: json["profileIconId"] ?? 29,
      summonerLevel: json['summonerLevel'] ?? 0
    );
  }
}