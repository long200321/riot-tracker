class GetSummonerRequest {
  final String puuid;

  GetSummonerRequest({required this.puuid});

  String toPath() {
    return "/lol/summoner/v4/summoners/by-puuid/$puuid";
  }

  String toGetRankPath() {
    return "/lol/league/v4/entries/by-puuid/$puuid";
  }

  String toChampionMasteryPath() {
    return "/lol/champion-mastery/v4/champion-masteries/by-puuid/$puuid/top";
  }
}