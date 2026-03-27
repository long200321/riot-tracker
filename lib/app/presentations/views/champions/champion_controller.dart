import 'package:get/get.dart';
import 'package:riot_tracker/app/core/routes/app_routes.dart';
import 'package:riot_tracker/app/data/champion/request/champion_detail_request.dart';
import 'package:riot_tracker/app/domain/champion/use-case/champion_usecase.dart';

import '../../../domain/champion/entities/champion.dart';

class ChampionController extends GetxController {
  final ChampionUsecase championsUseCase;

  ChampionController(this.championsUseCase);

  final champions = <Champion>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    fetchChampions();
    super.onInit();
  }

  Future<void> fetchChampions() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await championsUseCase.getListChampion();

      if (result != null) {
        champions.value = result.listChampions;
      } else {
        errorMessage.value = "Cant fetch data";
      }
    } catch (e) {
      errorMessage.value = "Error";
      print("❌ CONTROLLER ERROR: $e");
    } finally {
      isLoading.value = false;
    }
  }
}