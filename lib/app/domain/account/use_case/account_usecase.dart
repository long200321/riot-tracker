import 'package:riot_tracker/app/data/account/mapper/account_mapper.dart';
import 'package:riot_tracker/app/data/account/request/get_summoner_request.dart';
import 'package:riot_tracker/app/data/account/request/login_request.dart';
import 'package:riot_tracker/app/domain/account/repositories/account_repository.dart';

import '../entities/account.dart';

class AccountUsecase {
  final AccountRepository repository;

  AccountUsecase(this.repository);

  Future<Account?> login(LoginRequest request) {
    return repository.login(request);
  }


  Future<Account?> getFullAccount(String puuid) async {
    final login = await repository.getUser(LoginRequest(puuid: puuid));
    final summoner = await repository.getSummoner(GetSummonerRequest(puuid: puuid));
    final ranks = await repository.getSummonerRank(GetSummonerRequest(puuid: puuid));

    if (login == null) return null;

    var account = login.merge(summoner ?? Account());
    account = account.copyWith(ranks: ranks);

    return account;
  }

}