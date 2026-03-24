import 'package:riot_tracker/app/data/account/mapper/match_history_mapper.dart';
import 'package:riot_tracker/app/data/account/services/get_match_history_service.dart';
import 'package:riot_tracker/app/domain/account/repositories/match_history_repository.dart';

import '../../../domain/account/entities/match_history.dart';
import '../request/get_match_history_request.dart';

class MatchHistoryRepositoryImp implements MatchHistoryRepository {
  final GetMatchHistoryService matchHistoryService;

  MatchHistoryRepositoryImp({required this.matchHistoryService});

  @override
  Future<MatchHistory?> getListMatch(GetMatchHistoryRequest request) async {
    final response = await matchHistoryService.getListMatchHistory(request);
    return response?.toEntity();
  }

  @override
  Future<Match?> getMatch(GetMatchHistoryRequest request) async {
    final response = await matchHistoryService.getMatch(request);
    return response?.toEntity();
  }
}