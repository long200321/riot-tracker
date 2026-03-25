class ChampionMasteryResponse {
  final int championId;
  final int championLevel;
  final int championPoints;
  final int championPointsSinceLastLevel;
  final int championPointsUntilNextLevel;
  final String championName;

  ChampionMasteryResponse({
    required this.championId,
    required this.championLevel,
    required this.championPoints,
    required this.championPointsSinceLastLevel,
    required this.championPointsUntilNextLevel,
    required this.championName,
  });

  factory ChampionMasteryResponse.fromJson(
      Map<String, dynamic> json, Map<String, dynamic> championsData) {
    String name = '';
    championsData.forEach((key, value) {
      if (value['key'] == json['championId'].toString()) {
        name = value['id'];
      }
    });

    return ChampionMasteryResponse(
      championId: json['championId'],
      championLevel: json['championLevel'],
      championPoints: json['championPoints'],
      championPointsSinceLastLevel: json['championPointsSinceLastLevel'],
      championPointsUntilNextLevel: json['championPointsUntilNextLevel'],
      championName: name,
    );
  }
}