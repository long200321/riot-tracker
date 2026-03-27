import 'package:get/get.dart';
import 'package:riot_tracker/app/data/account/repositories_imp/account_repository_imp.dart';
import 'package:riot_tracker/app/data/account/services/account_service.dart';
import 'package:riot_tracker/app/data/account/services/get_summoner_service.dart';
import 'package:riot_tracker/app/data/champion/repositories_imp/champion_repository_imp.dart';
import 'package:riot_tracker/app/data/champion/services/champion_service.dart';
import 'package:riot_tracker/app/domain/account/use_case/account_usecase.dart';
import 'package:riot_tracker/app/domain/champion/use-case/champion_usecase.dart';
import 'package:riot_tracker/app/presentations/views/champions/champion_controller.dart';
import 'package:riot_tracker/app/presentations/views/widget_tree/widget_tree_view_controller.dart';

class WidgetTreeViewBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<WidgetTreeViewController>(
          () => WidgetTreeViewController(
        AccountUsecase(
          AccountRepositoryImpl(AccountService(), GetSummonerService()),
        ),
      ),
      fenix: true,
    );
    Get.lazyPut<ChampionController>(
          () => ChampionController(
            ChampionUsecase(
          ChampionRepositoryImpl(ChampionService()),
        ),
      ),
    );
  }
}