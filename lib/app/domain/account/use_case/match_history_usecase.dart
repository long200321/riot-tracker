import 'package:riot_tracker/app/data/account/request/get_match_history_request.dart';
import 'package:riot_tracker/app/domain/account/entities/match_history.dart';
import 'package:riot_tracker/app/domain/account/repositories/match_history_repository.dart';

class MatchHistoryUsecase {
  final MatchHistoryRepository repository;

  MatchHistoryUsecase({required this.repository});

  Future<MatchHistory?> getListMatch(GetMatchHistoryRequest request) {
    return repository.getListMatch(request);
  }
}