import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:riot_tracker/app/core/routes/app_routes.dart';
import 'package:riot_tracker/app/core/storage/user_storage.dart';
import 'package:riot_tracker/app/data/account/request/login_request.dart';
import 'package:riot_tracker/app/domain/account/use_case/account_usecase.dart';
import 'package:riot_tracker/app/ui/views/widget_tree/widget_tree_view.dart';

import '../../../domain/account/entities/account.dart';

class InitViewController extends GetxController {
  final AccountUsecase useCase;
  final TextEditingController gameNameController = TextEditingController();
  final TextEditingController tagLineController = TextEditingController();

  InitViewController(this.useCase);

  final RxString error = "".obs;

  Future<void> login() async {
    try {
      error.value = "";

      final result = await useCase.login(
        LoginRequest(
          gameName: gameNameController.text,
          tagLine: tagLineController.text,
        ),
      );

      if (result != null) {
        UserStorage.savePuuid(result.puuid ?? "");
        Get.offAllNamed(AppRoutes.widgetTree);
      } else {
        error.value = "No results found for player with riot id ${gameNameController.text}#${tagLineController.text}";
      }
    } on DioException catch (e) {
      error.value = e.response?.data;
    }
  }
}
