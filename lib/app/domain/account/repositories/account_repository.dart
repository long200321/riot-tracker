import 'package:riot_tracker/app/data/account/request/login_request.dart';

import '../entities/account.dart';

abstract class AccountRepository {
  Future<Account?> login(LoginRequest request);
}