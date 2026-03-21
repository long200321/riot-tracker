import 'package:get/get.dart';
import 'package:riot_tracker/app/ui/views/init/init_controller.dart';

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
              AccountService(),
            ),
          ),
        ));
  }
}