
import 'package:riot_tracker/app/data/account/mapper/account_mapper.dart';
import 'package:riot_tracker/app/data/account/request/login_request.dart';

import '../../../domain/account/entities/account.dart';
import '../../../domain/account/repositories/account_repository.dart';
import '../services/account_service.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountService service;

  AccountRepositoryImpl(this.service);

  @override
  Future<Account?> login(LoginRequest request) async {
    final response = await service.login(request);
    if (response != null) {
      return response.toEntity();
    }
  }

}