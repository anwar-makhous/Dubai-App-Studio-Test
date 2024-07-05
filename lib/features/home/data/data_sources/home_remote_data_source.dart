import 'package:dubai_app_studio/features/home/data/models/balance_model.dart';

abstract class HomeRemoteDataSource {
  Future<BalanceModel> getBalance();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<BalanceModel> getBalance() {
    // TODO: implement getBalance
    throw UnimplementedError();
  }
}
