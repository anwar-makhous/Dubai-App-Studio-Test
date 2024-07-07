import 'package:dubai_app_studio/core/usecases/send_amount_params.dart';
import 'package:dubai_app_studio/features/recharge/data/models/history_item_model.dart';

abstract class RechargeDataSource {
  Future<bool> sendAmount({required SendAmountParams params});
  Future<List<HistoryItemModel>> getRechargeHistory();
}
