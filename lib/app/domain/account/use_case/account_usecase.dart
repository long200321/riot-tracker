import 'package:riot_tracker/app/data/account/request/login_request.dart';
import 'package:riot_tracker/app/domain/account/repositories/account_repository.dart';

import '../entities/account.dart';

class AccountUsecase {
  final AccountRepository repository;

  AccountUsecase(this.repository);

  Future<Account?> login(LoginRequest request) {
    return repository.login(request);
  }
}