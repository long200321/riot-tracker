import 'package:get/get.dart';

import '../../../domain/champion/entities/champion.dart';
import '../../../domain/champion/use-case/champion_usecase.dart';

class ChampionDetailViewController extends GetxController {
  final ChampionUsecase usecase;

  ChampionDetailViewController(this.usecase);

  late Champion champ;

  var isLoading = false.obs;
  var selectedSkinIndex = 0.obs;

  @override
  void onInit() {
    champ = Get.arguments;
    fetchDetail();
    super.onInit();
  }

  Future fetchDetail() async {
    final detail = await usecase.getChampionDetail(champ.id);

    if (detail != null) {
      champ = detail;
      selectedSkinIndex.value = 0;
      update();
      isLoading.value = false;
    }
  }
}