class LoginRequest {
  final String? gameName;
  final String? puuid;

  LoginRequest({this.gameName, this.tagLine, this.puuid});

  final String? tagLine;

  String toLoginPath() {
    return "/riot/account/v1/accounts/by-riot-id/$gameName/$tagLine";
  }

  String toGetUserPath() {
    return "/riot/account/v1/accounts/by-puuid/$puuid";
  }
}