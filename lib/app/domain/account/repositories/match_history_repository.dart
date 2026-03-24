import 'package:riot_tracker/app/data/account/request/get_match_history_request.dart';
import 'package:riot_tracker/app/domain/account/entities/match_history.dart';

abstract class MatchHistoryRepository {
  Future<MatchHistory?> getListMatch(GetMatchHistoryRequest request);
  Future<Match?> getMatch(GetMatchHistoryRequest request);
}