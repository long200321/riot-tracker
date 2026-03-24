class GetMatchHistoryResponse {
  final List<String>? listMatch;

  GetMatchHistoryResponse({required this.listMatch});
  factory GetMatchHistoryResponse.fromJson(List<dynamic> json) {
    return GetMatchHistoryResponse(
      listMatch: List<String>.from(json),
    );
  }
}

class MatchResponse {
  final InfoResponse? info;

  MatchResponse({this.info});

  factory MatchResponse.fromJson(Map<String, dynamic> json) {
    return MatchResponse(
      info: json['info'] != null ? InfoResponse.fromJson(json['info']) : null,
    );
  }
}

class InfoResponse {
  final String? gameMode;
  final List<ParticipantResponse>? participants;

  InfoResponse({this.gameMode, this.participants});

  factory InfoResponse.fromJson(Map<String, dynamic> json) {
    return InfoResponse(
      gameMode: json['gameMode'],
      participants: (json['participants'] as List?)
          ?.map((e) => ParticipantResponse.fromJson(e))
          .toList(),
    );
  }
}

class ParticipantResponse {
  final int? assists;
  final String? championName;
  final String? puuid;
  final int? deaths;
  final int? kills;
  final String? role;
  final int? summoner1Id;
  final int? summoner2Id;
  final bool? win;

  final int? item0;
  final int? item1;
  final int? item2;
  final int? item3;
  final int? item4;
  final int? item5;
  final int? item6;

  ParticipantResponse({
    this.assists,
    this.championName,
    this.puuid,
    this.deaths,
    this.kills,
    this.role,
    this.summoner1Id,
    this.summoner2Id,
    this.win,
    this.item0,
    this.item1,
    this.item2,
    this.item3,
    this.item4,
    this.item5,
    this.item6,
  });

  factory ParticipantResponse.fromJson(Map<String, dynamic> json) {
    return ParticipantResponse(
      assists: json['assists'],
      championName: json['championName'],
      puuid: json['puuid'],
      deaths: json['deaths'],
      kills: json['kills'],
      role: json['role'],
      summoner1Id: json['summoner1Id'],
      summoner2Id: json['summoner2Id'],
      win: json['win'],
      item0: json['item0'],
      item1: json['item1'],
      item2: json['item2'],
      item3: json['item3'],
      item4: json['item4'],
      item5: json['item5'],
      item6: json['item6'],
    );
  }
}

