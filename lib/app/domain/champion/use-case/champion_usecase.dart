import 'package:riot_tracker/app/data/champion/request/champion_detail_request.dart';

import '../entities/champion.dart';
import '../repositories/champion_repository.dart';

class ChampionUsecase {
  final ChampionRepository repository;

  ChampionUsecase(this.repository);
  
  Future<ListChampion?> getListChampion() async {
    return await repository.getListChampion();
  }

  Future<Champion?> getChampionDetail(String id) async {
    return await repository.getChampionDetail(id);
  }
}