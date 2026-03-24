class GetMatchHistoryResponse {
  final List<String>? listMatch;

  GetMatchHistoryResponse({required this.listMatch});
  factory GetMatchHistoryResponse.fromJson(List<dynamic> json) {
    return GetMatchHistoryResponse(
      listMatch: List<String>.from(json),
    );
  }
}