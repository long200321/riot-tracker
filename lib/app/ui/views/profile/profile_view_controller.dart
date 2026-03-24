import 'package:get/get.dart';
import 'package:riot_tracker/app/core/storage/user_storage.dart';
import 'package:riot_tracker/app/data/account/request/get_match_history_request.dart';
import 'package:riot_tracker/app/domain/account/entities/match_history.dart';
import 'package:riot_tracker/app/domain/account/use_case/match_history_usecase.dart';

class ProfileViewController extends GetxController {
  final MatchHistoryUsecase usecase;
  final listMatch = Rxn<MatchHistory>();

  ProfileViewController(this.usecase);

  Future _getListMatch() async {
    final String _puuid = await UserStorage.getPuuid() ?? "";
    listMatch.value = await usecase.getListMatch(
      GetMatchHistoryRequest(puuid: _puuid)
    );
  }

  @override
  void onInit() {
    _getListMatch();
    super.onInit();
  }
}