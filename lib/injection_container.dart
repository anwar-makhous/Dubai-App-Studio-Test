import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'package:dubai_app_studio/core/network/network_info.dart';
import 'package:dubai_app_studio/core/services/app_storage.dart';
import 'package:dubai_app_studio/features/account/data/data_sources/account_data_source.dart';
import 'package:dubai_app_studio/features/account/data/data_sources/account_remote_data_source.dart';
import 'package:dubai_app_studio/features/account/data/repositories/account_repository_impl.dart';
import 'package:dubai_app_studio/features/account/domain/repositories/account_repository.dart';
import 'package:dubai_app_studio/features/account/domain/usecases/get_account_info.dart';
import 'package:dubai_app_studio/features/account/presentation/blocs/account_bloc/account_bloc.dart';
import 'package:dubai_app_studio/features/beneficiary/data/data_sources/beneficiary_data_source.dart';
import 'package:dubai_app_studio/features/beneficiary/data/data_sources/beneficiary_remote_data_source.dart';
import 'package:dubai_app_studio/features/beneficiary/data/repositories/beneficiary_repository_impl.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/repositories/beneficiary_repository.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/usecases/add_beneficiary.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/usecases/delete_beneficiary.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/usecases/get_beneficiaries.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/usecases/send_otp.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/usecases/verify_otp.dart';
import 'package:dubai_app_studio/features/beneficiary/presentation/blocs/beneficiaries_bloc/beneficiaries_bloc.dart';
import 'package:dubai_app_studio/features/recharge/data/data_sources/recharge_data_source.dart';
import 'package:dubai_app_studio/features/recharge/data/data_sources/recharge_remote_data_source.dart';
import 'package:dubai_app_studio/features/recharge/data/repositories/recharge_repository_impl.dart';
import 'package:dubai_app_studio/features/recharge/domain/repositories/recharge_repository.dart';
import 'package:dubai_app_studio/features/recharge/domain/usecases/get_recharge_history.dart';
import 'package:dubai_app_studio/features/recharge/domain/usecases/send_amount.dart';
import 'package:dubai_app_studio/features/recharge/presentation/blocs/history_bloc/history_bloc.dart';
import 'package:dubai_app_studio/features/recharge/presentation/blocs/recharge_bloc/recharge_bloc.dart';
import 'package:dubai_app_studio/server/app_http_services/app_http_services.dart';
import 'package:dubai_app_studio/server/app_server.dart';

final sl = GetIt.instance;
void initServiceLocator() {
  /// BLoC
  sl.registerFactory<AccountBloc>(() => AccountBloc(getAccountInfo: sl()));
  sl.registerFactory<HistoryBloc>(() => HistoryBloc(getRechargeHistory: sl()));
  sl.registerFactory<RechargeBloc>(() => RechargeBloc(sendAmount: sl()));
  sl.registerFactory<BeneficiariesBloc>(
    () => BeneficiariesBloc(
      addBeneficiary: sl(),
      deleteBeneficiary: sl(),
      sendOtp: sl(),
      verifyOtp: sl(),
      getBeneficiaries: sl(),
    ),
  );

  /// Usecases
  sl.registerLazySingleton<GetAccountInfo>(
      () => GetAccountInfo(repository: sl()));
  sl.registerLazySingleton<GetRechargeHistory>(
      () => GetRechargeHistory(repository: sl()));
  sl.registerLazySingleton<SendAmount>(() => SendAmount(repository: sl()));
  sl.registerLazySingleton<AddBeneficiary>(
      () => AddBeneficiary(repository: sl()));
  sl.registerLazySingleton<DeleteBeneficiary>(
      () => DeleteBeneficiary(repository: sl()));
  sl.registerLazySingleton<SendOtp>(() => SendOtp(repository: sl()));
  sl.registerLazySingleton<VerifyOtp>(() => VerifyOtp(repository: sl()));
  sl.registerLazySingleton<GetBeneficiaries>(
      () => GetBeneficiaries(repository: sl()));

  /// Repositories
  sl.registerLazySingleton<AccountRepository>(
      () => AccountRepositoryImpl(networkInfo: sl(), remoteDataSource: sl()));
  sl.registerLazySingleton<RechargeRepository>(
      () => RechargeRepositoryImpl(networkInfo: sl(), remoteDataSource: sl()));
  sl.registerLazySingleton<BeneficiaryRepository>(() =>
      BeneficiaryRepositoryImpl(networkInfo: sl(), remoteDataSource: sl()));

  /// Data Sources
  sl.registerLazySingleton<AccountDataSource>(
      () => AccountRemoteDataSource(client: sl()));
  sl.registerLazySingleton<RechargeDataSource>(
      () => RechargeRemoteDataSource(client: sl()));
  sl.registerLazySingleton<BeneficiaryDataSource>(
      () => BeneficiaryRemoteDataSource(client: sl()));

  // Utils
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));
  sl.registerLazySingleton<AppStorage>(
      () => AppStorageImpl(flutterSecureStorage: sl()));

  // External Dependencies
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());
  sl.registerLazySingleton<http.Client>(
    () => AppServer(
      historyService: sl(),
      otpService: sl(),
      accountInfoService: sl(),
      rechargeService: sl(),
      beneficiaryService: sl(),
    ),
  );

  // Fake HTTP Services
  sl.registerLazySingleton<AppHistoryHttpService>(
      () => AppHistoryHttpService(storage: sl()));
  sl.registerLazySingleton<AppOtpServiceHttpService>(
      () => AppOtpServiceHttpService(storage: sl()));
  sl.registerLazySingleton<AppAccountInfoHttpService>(
      () => AppAccountInfoHttpService(storage: sl()));
  sl.registerLazySingleton<AppRechargeHttpService>(
      () => AppRechargeHttpService(storage: sl()));
  sl.registerLazySingleton<AppBeneficiaryHttpService>(
      () => AppBeneficiaryHttpService(storage: sl()));
}
