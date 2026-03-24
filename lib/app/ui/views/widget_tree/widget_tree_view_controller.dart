import 'package:get/get.dart';
import 'package:riot_tracker/app/core/storage/user_storage.dart';
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
    super.onInit();
    Get.lazyPut<ProfileViewController>(() => ProfileViewController(
      MatchHistoryUsecase(
        repository: MatchHistoryRepositoryImp(matchHistoryService: GetMatchHistoryService())
      )
    ));
  }

  final AccountUsecase accountUsecase;
  WidgetTreeViewController(this.accountUsecase);

  final RxInt selectedPage = 1.obs;
  final account = Rxn<Account>();
  final RxBool isLoading = true.obs;
  final RxDouble winrate = 0.0.obs;
  final RxInt currentIndexSlider = 0.obs;

  Future _getUser() async {
    isLoading.value = true;
    final puuid = await UserStorage.getPuuid();
    account.value = await accountUsecase.getFullAccount(puuid ?? "");
    if (account.value != null) {
      isLoading.value = false;
    }
  }
}
