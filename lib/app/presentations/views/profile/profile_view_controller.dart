import 'package:get/get.dart';
import 'package:riot_tracker/app/core/storage/user_storage.dart';
import 'package:riot_tracker/app/data/account/request/get_match_history_request.dart';
import 'package:riot_tracker/app/domain/account/entities/match_history.dart';
import 'package:riot_tracker/app/domain/account/use_case/match_history_usecase.dart';

class ProfileViewController extends GetxController {
  final MatchHistoryUsecase usecase;
  final listMatchID = Rxn<MatchHistory>();
  final RxList<Match> listMatch = <Match>[].obs;
  final hasMore = true.obs;
  final RxDouble winRate = 0.0.obs;

  ProfileViewController(this.usecase);

  Future<void> _getListMatch() async {
    final String puuid = await UserStorage.getPuuid() ?? "";

    listMatchID.value = await usecase.getListMatch(
      GetMatchHistoryRequest(puuid: puuid),
    );

    final ids = listMatchID.value?.listMatch ?? [];

    const batchSize = 5;
    final List<Match> matches = [];

    for (int i = 0; i < ids.length; i += batchSize) {
      final batch = ids.skip(i).take(batchSize);

      final results = await Future.wait(
        batch.map((id) => _safeGetMatch(id)),
      );

      matches.addAll(results.whereType<Match>());

      await Future.delayed(const Duration(milliseconds: 500));
    }

    listMatch.value = matches;
    hasMore.value = false;

    int win = 0;
    int lose = 0;

    for (final match in matches) {
      final participant = match.participants.firstWhere(
            (p) => p.puuid == puuid,
        orElse: () => match.participants.first,
      );

      if (participant.win == true) {
        win++;
      } else {
        lose++;
      }
    }

    final total = win + lose;
    winRate.value = total > 0 ? (win / total) * 100 : 0;
  }

  Future<Match?> _safeGetMatch(String id) async {
    try {
      return await usecase.getMatch(
        GetMatchHistoryRequest(matchId: id),
      );
    } catch (e) {
      if (e.toString().contains('429')) {
        await Future.delayed(const Duration(seconds: 2));

        try {
          return await usecase.getMatch(
            GetMatchHistoryRequest(matchId: id),
          );
        } catch (_) {
          return null;
        }
      }
      return null;
    }
  }

  @override
  void onInit() {
    _getListMatch();
    super.onInit();
  }
}