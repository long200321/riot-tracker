import 'package:get/get.dart';
import 'package:riot_tracker/app/core/storage/user_storage.dart';
import 'package:riot_tracker/app/data/account/mapper/account_mapper.dart';
import 'package:riot_tracker/app/data/account/request/get_summoner_request.dart';
import 'package:riot_tracker/app/data/account/request/login_request.dart';
import 'package:riot_tracker/app/domain/account/entities/account.dart';
import 'package:riot_tracker/app/domain/account/use_case/account_usecase.dart';

class WidgetTreeViewController extends GetxController {
  @override
  void onInit() {
    _getUser();
    super.onInit();
  }
  final AccountUsecase accountUsecase;
  WidgetTreeViewController(this.accountUsecase);

  final RxInt selectedPage = 1.obs;
  final account = Rxn<Account>();
  final RxBool isLoading = true.obs;

  Future _getUser() async {
    isLoading.value = true;
    final puuid = await UserStorage.getPuuid();
    account.value = await accountUsecase.getFullAccount(puuid ?? "");
    if (account.value != null) {
      isLoading.value = false;
    }
  }

}