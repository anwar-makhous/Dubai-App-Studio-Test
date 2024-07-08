import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:dubai_app_studio/core/constants/app_constants.dart';
import 'package:dubai_app_studio/core/error/error.dart';
import 'package:dubai_app_studio/features/account/data/data_sources/account_data_source.dart';
import 'package:dubai_app_studio/features/account/data/models/account_model.dart';

class AccountRemoteDataSource implements AccountDataSource {
  final http.Client client;

  AccountRemoteDataSource({required this.client});

  @override
  Future<AccountInfoModel> getAccountInfo() async {
    final Uri uri = Uri.parse('${AppConfig.apiBaseUrl}/account_info');
    final http.Response response = await client.get(uri);
    response.checkException();
    return AccountInfoModel.fromJson(jsonDecode(response.body));
  }
}
