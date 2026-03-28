class ChampionDetailRequest {
  final String champId;

  ChampionDetailRequest({required this.champId});

  String toPath() {
    return "/data/vi_VN/champion/${champId}.json";
  }
}