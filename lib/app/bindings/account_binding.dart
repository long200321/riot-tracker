import 'package:get/get.dart';
import 'package:riot_tracker/app/data/account/services/get_summoner_service.dart';
import 'package:riot_tracker/app/presentations/views/init/init_controller.dart';
import 'package:riot_tracker/app/presentations/views/splash/splash_view_controller.dart';

import '../data/account/repositories_imp/account_repository_imp.dart';
import '../data/account/services/account_service.dart';
import '../domain/account/use_case/account_usecase.dart';

class AccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InitViewController>(() =>
        InitViewController(
          AccountUsecase(
            AccountRepositoryImpl(
              AccountService(), GetSummonerService()
            ),
          ),
        ));
    Get.put(SplashViewController());
  }
}