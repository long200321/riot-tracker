import 'package:get/get.dart';
import 'package:riot_tracker/app/data/champion/repositories_imp/champion_repository_imp.dart';
import 'package:riot_tracker/app/data/champion/services/champion_service.dart';
import 'package:riot_tracker/app/domain/champion/use-case/champion_usecase.dart';

import '../presentations/views/champions/champion_detail_view_controller.dart';

class ChampionDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChampionDetailViewController>(
          () => ChampionDetailViewController(
            ChampionUsecase(
              ChampionRepositoryImpl(
                ChampionService()
              )
            )
      ),
    );
  }
}