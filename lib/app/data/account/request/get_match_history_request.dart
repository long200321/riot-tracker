class GetMatchHistoryRequest {
  final String? puuid;
  final String? type;
  final String? matchId;

  GetMatchHistoryRequest({this.puuid, this.type = "", this.matchId});

  String toListMatch() {
    return "/lol/match/v5/matches/by-puuid/$puuid/ids?type=$type&start=0&count=20&";
  }
  String toMatch() {
    return "/lol/match/v5/matches/$matchId";
  }
}