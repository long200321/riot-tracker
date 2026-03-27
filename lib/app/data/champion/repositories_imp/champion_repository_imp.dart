import 'package:riot_tracker/app/data/champion/mapper/champion_mapper.dart';
import 'package:riot_tracker/app/data/champion/request/champion_detail_request.dart';

import '../../../domain/champion/entities/champion.dart';
import '../../../domain/champion/repositories/champion_repository.dart';
import '../services/champion_service.dart';

class ChampionRepositoryImpl implements ChampionRepository {
  final ChampionService service;

  ChampionRepositoryImpl(this.service);

  @override
  Future<ListChampion?> getListChampion() async {
    try {
      final response = await service.getChampions();

      if (response == null) return null;

      return response.toEntity();
    } catch (e) {
      print("❌ REPOSITORY ERROR: $e");
      return null;
    }
  }

  @override
  Future<Champion?> getChampionDetail(String id) async {
    try {
      final response = await service.getChampionDetail(
        ChampionDetailRequest(champId: id),
      );

      if (response == null) return null;

      return response.toEntity();
    } catch (e) {
      print("❌ REPOSITORY ERROR: $e");
      return null;
    }
  }
}