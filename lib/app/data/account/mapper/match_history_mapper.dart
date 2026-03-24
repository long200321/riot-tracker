import 'package:riot_tracker/app/data/account/response/get_match_history_response.dart';
import 'package:riot_tracker/app/domain/account/entities/match_history.dart';

extension MatchHistoryMapper on GetMatchHistoryResponse {
  MatchHistory toEntity() {
    return MatchHistory(
      listMatch: listMatch ?? []
    );
  }
}