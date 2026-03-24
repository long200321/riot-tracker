import 'package:get/get.dart';
import 'package:riot_tracker/app/core/storage/user_storage.dart';
import 'package:riot_tracker/app/data/account/mapper/account_mapper.dart';
import 'package:riot_tracker/app/data/account/request/get_summoner_request.dart';
import 'package:riot_tracker/app/data/account/request/login_request.dart';
import 'package:riot_tracker/app/domain/account/entities/account.dart';
import 'package:riot_tracker/app/domain/account/use_case/account_usecase.dart';

import '../../../data/account/repositories_imp/match_history_repository_imp.dart';
import '../../../data/account/services/get_match_history_service.dart';
import '../../../domain/account/use_case/match_history_usecase.dart';
import '../profile/profile_view_controller.dart';

class WidgetTreeViewController extends GetxController {
  @override
  void onInit() {
    _getUser();
    Get.put(ProfileViewController(
      MatchHistoryUsecase(
        repository: MatchHistoryRepositoryImp(
          matchHistoryService: GetMatchHistoryService(),
        ),
      ),
    ));
    super.onInit();
  }
  final AccountUsecase accountUsecase;
  WidgetTreeViewController(this.accountUsecase);

  final RxInt selectedPage = 1.obs;
  final account = Rxn<Account>();
  final RxBool isLoading = true.obs;
  final RxDouble winrate = 0.0.obs;

  Future _getUser() async {
    isLoading.value = true;
    final puuid = await UserStorage.getPuuid();
    account.value = await accountUsecase.getFullAccount(puuid ?? "");
    if (account.value != null) {
      winrate.value = getWinRate(account.value?.ranks ?? []);
      isLoading.value = false;
    }
  }

  double getWinRate(List<Rank> array) {
    int totalWins = array.fold(0, (sum, item) => sum + item.wins);
    int totalLosses = array.fold(0, (sum, item) => sum + item.losses);
    int totalGames = totalWins + totalLosses;

    if (totalGames == 0) return 0;
    return totalWins / totalGames;
  }

}