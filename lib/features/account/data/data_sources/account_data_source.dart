import 'package:dubai_app_studio/features/account/data/models/account_model.dart';

abstract class AccountDataSource {
  Future<AccountInfoModel> getAccountInfo();
}
