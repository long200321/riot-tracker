class GetSummonerRequest {
  final String puuid;

  GetSummonerRequest({required this.puuid});

  String toPath() {
    return "/lol/summoner/v4/summoners/by-puuid/$puuid";
  }

  String toGetRankPath() {
    return "/lol/league/v4/entries/by-puuid/$puuid";
  }
}