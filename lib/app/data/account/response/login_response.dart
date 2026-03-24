class LoginResponse {
  final String puuid;

  LoginResponse({
    required this.puuid,
    required this.gameName,
    required this.tagLine,
  });

  final String gameName;
  final String tagLine;

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      puuid: json["puuid"] ?? "",
      gameName: json["gameName"] ?? "",
      tagLine: json["tagLine"] ?? "",
    );
  }
}
