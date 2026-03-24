class GetMatchHistoryRequest {
  final String puuid;
  final String? type;

  GetMatchHistoryRequest({required this.puuid, this.type = ""});

  String toListMatch() {
    return "/lol/match/v5/matches/by-puuid/$puuid/ids?type=$type&start=0&count=20&";
  }
}