import 'package:riot_tracker/app/data/champion/request/champion_detail_request.dart';

import '../entities/champion.dart';

abstract class ChampionRepository {
  Future<ListChampion?> getListChampion();
  Future<Champion?> getChampionDetail(String id);
}