import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:dubai_app_studio/core/constants/app_constants.dart';
import 'package:dubai_app_studio/core/error/error.dart';
import 'package:dubai_app_studio/core/usecases/add_beneficiary_params.dart';
import 'package:dubai_app_studio/core/usecases/delete_beneficiary_params.dart';
import 'package:dubai_app_studio/core/usecases/send_otp_params.dart';
import 'package:dubai_app_studio/core/usecases/verify_otp_params.dart';
import 'package:dubai_app_studio/features/beneficiary/data/data_sources/beneficiary_data_source.dart';
import 'package:dubai_app_studio/features/beneficiary/data/models/beneficiary_model.dart';

class BeneficiaryRemoteDataSource implements BeneficiaryDataSource {
  final http.Client client;

  BeneficiaryRemoteDataSource({required this.client});

  @override
  Future<bool> addBeneficiary({required AddBeneficiaryParams params}) async {
    final Uri uri = Uri.parse('${AppConfig.apiBaseUrl}/add_beneficiary');
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
  Future<List<BeneficiaryModel>> getBeneficiaries() async {
    final Uri uri = Uri.parse('${AppConfig.apiBaseUrl}/beneficiaries');
    final http.Response response = await client.get(uri);
    response.checkException();
    List<BeneficiaryModel> result = (jsonDecode(response.body) as List<dynamic>)
        .map((e) => BeneficiaryModel.fromJson(e))
        .toList();
    return result;
  }

  @override
  Future<bool> sendOtp({required SendOtpParams params}) async {
    final Uri uri = Uri.parse('${AppConfig.apiBaseUrl}/send_otp');
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
  Future<bool> verifyOtp({required VerifyOtpParams params}) async {
    final Uri uri = Uri.parse('${AppConfig.apiBaseUrl}/verify_otp');
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
  Future<bool> deleteBeneficiary(
      {required DeleteBeneficiaryParams params}) async {
    final Uri uri = Uri.parse('${AppConfig.apiBaseUrl}/beneficiary');
    final Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    final http.Response response = await client.delete(
      uri,
      headers: headers,
      body: params.toJson(),
    );
    response.checkException();
    return true;
  }
}
