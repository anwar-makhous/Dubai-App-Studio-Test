import 'dart:convert';
import 'dart:io';

import 'package:dubai_app_studio/features/recharge/data/data_sources/recharge_data_source.dart';
import 'package:dubai_app_studio/features/recharge/data/models/history_item_model.dart';
import 'package:http/http.dart' as http;

import 'package:dubai_app_studio/core/constants/app_constants.dart';
import 'package:dubai_app_studio/core/error/error.dart';
import 'package:dubai_app_studio/core/usecases/send_amount_params.dart';

class RechargeRemoteDataSource implements RechargeDataSource {
  final http.Client client;

  RechargeRemoteDataSource({required this.client});

  @override
  Future<bool> sendAmount({required SendAmountParams params}) async {
    final Uri uri = Uri.parse('${AppConfig.apiBaseUrl}/recharge');
    final Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    final http.Response response = await client.post(
      uri,
      headers: headers,
      body: params.toJson(),
    );
    response.checkException();
    return true;
  }

  @override
  Future<List<HistoryItemModel>> getRechargeHistory() async {
    final Uri uri = Uri.parse('${AppConfig.apiBaseUrl}/history');
    final http.Response response = await client.get(uri);
    response.checkException();
    final result = jsonDecode(response.body);
    return (result as List<dynamic>)
        .map((e) => HistoryItemModel.fromJson(e))
        .toList();
  }
}
