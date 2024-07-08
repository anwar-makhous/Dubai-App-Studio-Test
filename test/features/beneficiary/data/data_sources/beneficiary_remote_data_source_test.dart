import 'dart:convert';

import 'package:dubai_app_studio/core/usecases/add_beneficiary_params.dart';
import 'package:dubai_app_studio/core/usecases/delete_beneficiary_params.dart';
import 'package:dubai_app_studio/core/usecases/send_otp_params.dart';
import 'package:dubai_app_studio/core/usecases/verify_otp_params.dart';
import 'package:dubai_app_studio/features/beneficiary/data/data_sources/beneficiary_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'package:dubai_app_studio/core/error/error.dart';
import 'package:dubai_app_studio/features/beneficiary/data/models/beneficiary_model.dart';

import '../../../../mocks/mock_http_client.dart';

void main() {
  late BeneficiaryRemoteDataSource beneficiaryRemoteDataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    beneficiaryRemoteDataSource =
        BeneficiaryRemoteDataSource(client: mockHttpClient);
  });

  group('BeneficiaryRemoteDataSource', () {
    const List<BeneficiaryModel> tBeneficiaries = [
      BeneficiaryModel(
        name: "Sarah",
        phoneNumber: "551234567",
        isVerified: true,
        totalTransactions: 100.00,
      ),
      BeneficiaryModel(
        name: "Ali",
        phoneNumber: "551222567",
        isVerified: false,
        totalTransactions: 50.00,
      ),
      BeneficiaryModel(
        name: "Jack",
        phoneNumber: "551234123",
        isVerified: true,
        totalTransactions: 200.00,
      ),
    ];

    final tBeneficiariesResponse = jsonEncode(tBeneficiaries
        .map((e) => {
              'name': e.name,
              'phoneNumber': e.phoneNumber,
              'isVerified': e.isVerified,
              'totalTransactions': e.totalTransactions,
            })
        .toList());

    final tEmptyBeneficiariesResponse = jsonEncode([]);

    final AddBeneficiaryParams tAddParams =
        AddBeneficiaryParams(name: "New Beneficiary", phoneNumber: "551234567");
    final DeleteBeneficiaryParams tDeleteParams =
        DeleteBeneficiaryParams(phoneNumber: "551234567");
    final SendOtpParams tSendOtpParams =
        SendOtpParams(phoneNumber: "551234567");
    final VerifyOtpParams tVerifyOtpParams =
        VerifyOtpParams(phoneNumber: "551234567", otp: "1234");

    test(
        'returns List<BeneficiaryModel> when getBeneficiaries() is called and response is 200',
        () async {
      when(mockHttpClient.get(any))
          .thenAnswer((_) async => http.Response(tBeneficiariesResponse, 200));
      final result = await beneficiaryRemoteDataSource.getBeneficiaries();
      expect(result, isA<List<BeneficiaryModel>>());
      expect(result, tBeneficiaries);
    });

    test(
        'returns empty List<BeneficiaryModel> when getBeneficiaries() is called and response is empty list',
        () async {
      when(mockHttpClient.get(any)).thenAnswer(
          (_) async => http.Response(tEmptyBeneficiariesResponse, 200));
      final result = await beneficiaryRemoteDataSource.getBeneficiaries();
      expect(result, isA<List<BeneficiaryModel>>());
      expect(result, []);
    });

    test(
        'throw ServerException when getBeneficiaries() is called and response is 500',
        () async {
      when(mockHttpClient.get(any))
          .thenAnswer((_) async => http.Response("", 500));
      expect(() async => await beneficiaryRemoteDataSource.getBeneficiaries(),
          throwsA(isA<ServerException>()));
    });

    test('returns true when addBeneficiary() is called with the right params',
        () async {
      when(mockHttpClient.post(any,
              headers: anyNamed("headers"), body: tAddParams.toJson()))
          .thenAnswer((_) async => http.Response("success", 200));
      final result =
          await beneficiaryRemoteDataSource.addBeneficiary(params: tAddParams);
      expect(result, true);
    });

    test(
        'throw ServerException when addBeneficiary() is called and response is 500',
        () async {
      when(mockHttpClient.post(any,
              headers: anyNamed("headers"), body: tAddParams.toJson()))
          .thenAnswer((_) async => http.Response("error", 500));
      expect(
          () async => await beneficiaryRemoteDataSource.addBeneficiary(
              params: tAddParams),
          throwsA(isA<ServerException>()));
    });

    test('returns true when sendOtp() is called with the right params',
        () async {
      when(mockHttpClient.post(any,
              headers: anyNamed("headers"), body: tSendOtpParams.toJson()))
          .thenAnswer((_) async => http.Response("success", 200));
      final result =
          await beneficiaryRemoteDataSource.sendOtp(params: tSendOtpParams);
      expect(result, true);
    });

    test('throw ServerException when sendOtp() is called and response is 500',
        () async {
      when(mockHttpClient.post(any,
              headers: anyNamed("headers"), body: tSendOtpParams.toJson()))
          .thenAnswer((_) async => http.Response("error", 500));
      expect(
          () async =>
              await beneficiaryRemoteDataSource.sendOtp(params: tSendOtpParams),
          throwsA(isA<ServerException>()));
    });

    test('returns true when verifyOtp() is called with the right params',
        () async {
      when(mockHttpClient.post(any,
              headers: anyNamed("headers"), body: tVerifyOtpParams.toJson()))
          .thenAnswer((_) async => http.Response("success", 200));
      final result =
          await beneficiaryRemoteDataSource.verifyOtp(params: tVerifyOtpParams);
      expect(result, true);
    });

    test('throw ServerException when verifyOtp() is called and response is 500',
        () async {
      when(mockHttpClient.post(any,
              headers: anyNamed("headers"), body: tVerifyOtpParams.toJson()))
          .thenAnswer((_) async => http.Response("error", 500));
      expect(
          () async => await beneficiaryRemoteDataSource.verifyOtp(
              params: tVerifyOtpParams),
          throwsA(isA<ServerException>()));
    });

    test(
        'returns true when deleteBeneficiary() is called with the right params',
        () async {
      when(mockHttpClient.delete(any,
              headers: anyNamed("headers"), body: tDeleteParams.toJson()))
          .thenAnswer((_) async => http.Response("success", 200));
      final result = await beneficiaryRemoteDataSource.deleteBeneficiary(
          params: tDeleteParams);
      expect(result, true);
    });

    test(
        'throw ServerException when deleteBeneficiary() is called and response is 500',
        () async {
      when(mockHttpClient.delete(any,
              headers: anyNamed("headers"), body: tDeleteParams.toJson()))
          .thenAnswer((_) async => http.Response("error", 500));
      expect(
          () async => await beneficiaryRemoteDataSource.deleteBeneficiary(
              params: tDeleteParams),
          throwsA(isA<ServerException>()));
    });
  });
}
