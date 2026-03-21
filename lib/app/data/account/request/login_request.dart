class LoginRequest {
  final String gameName;

  LoginRequest({required this.gameName, required this.tagLine});

  final String tagLine;

  String toLoginPath() {
    return "/riot/account/v1/accounts/by-riot-id/$gameName/$tagLine";
  }
}
