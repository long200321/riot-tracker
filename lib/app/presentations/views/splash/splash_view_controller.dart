import 'package:get/get.dart';
import 'package:riot_tracker/app/core/routes/app_routes.dart';
import 'package:riot_tracker/app/core/storage/user_storage.dart';

class SplashViewController extends GetxController {
  final _puuid = Rxn<String>();

  @override
  void onInit() {
    _getPuuid();
    super.onInit();
  }

  Future _getPuuid() async {
    _puuid.value = await UserStorage.getPuuid();
    if (_puuid.value == null || _puuid.value!.isEmpty) {
      Get.offAllNamed(AppRoutes.init);
    } else {
      Get.offAllNamed(AppRoutes.widgetTree);
    }
  }
}