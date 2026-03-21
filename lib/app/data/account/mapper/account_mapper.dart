import 'package:riot_tracker/app/data/account/response/login_response.dart';
import 'package:riot_tracker/app/domain/account/entities/account.dart';

extension AccountMapper on LoginResponse {
  Account toEntity() {
    return Account(
      puuid: puuid ?? "",
      gameName: gameName ?? "",
      tagLine: tagLine ?? "",
    );
  }
}
