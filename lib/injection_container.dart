import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/usecases/delete_beneficiary.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'package:dubai_app_studio/core/network/network_info.dart';
import 'package:dubai_app_studio/core/services/app_storage.dart';
import 'package:dubai_app_studio/core/services/mock_http_server.dart';
import 'package:dubai_app_studio/features/beneficiary/data/data_sources/beneficiary_remote_data_source.dart';
import 'package:dubai_app_studio/features/beneficiary/data/repositories/beneficiary_repository_impl.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/repositories/beneficiary_repository.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/usecases/add_beneficiary.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/usecases/get_beneficiaries.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/usecases/send_otp.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/usecases/verify_otp.dart';
import 'package:dubai_app_studio/features/beneficiary/presentation/blocs/beneficiaries_bloc/beneficiaries_bloc.dart';
import 'package:dubai_app_studio/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:dubai_app_studio/features/home/data/repositories/home_repository_impl.dart';
import 'package:dubai_app_studio/features/home/domain/repositories/home_repository.dart';
import 'package:dubai_app_studio/features/home/domain/usecases/get_balance.dart';
import 'package:dubai_app_studio/features/home/presentation/blocs/home_bloc/home_bloc.dart';
import 'package:dubai_app_studio/features/recharge/data/data_sources/recharge_remote_data_source.dart';
import 'package:dubai_app_studio/features/recharge/data/repositories/recharge_repository_impl.dart';
import 'package:dubai_app_studio/features/recharge/domain/repositories/recharge_repository.dart';
import 'package:dubai_app_studio/features/recharge/domain/usecases/get_recharge_history.dart';
import 'package:dubai_app_studio/features/recharge/domain/usecases/send_amount.dart';
import 'package:dubai_app_studio/features/recharge/presentation/blocs/history_bloc/history_bloc.dart';
import 'package:dubai_app_studio/features/recharge/presentation/blocs/recharge_bloc/recharge_bloc.dart';

final sl = GetIt.instance;
void initServiceLocator() {
  /// BLoC
  sl.registerFactory<HomeBloc>(() => HomeBloc(getBalance: sl()));
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
  sl.registerLazySingleton<GetBalance>(() => GetBalance(repository: sl()));
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
  sl.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(networkInfo: sl(), remoteDataSource: sl()));
  sl.registerLazySingleton<RechargeRepository>(
      () => RechargeRepositoryImpl(networkInfo: sl(), remoteDataSource: sl()));
  sl.registerLazySingleton<BeneficiaryRepository>(() =>
      BeneficiaryRepositoryImpl(networkInfo: sl(), remoteDataSource: sl()));

  /// Data Sources
  sl.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<RechargeRemoteDataSource>(
      () => RechargeRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<BeneficiaryRemoteDataSource>(
      () => BeneficiaryRemoteDataSourceImpl(client: sl()));

  // Utils
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));
  sl.registerLazySingleton<AppStorage>(
      () => AppStorageImpl(flutterSecureStorage: sl()));

  // External Dependencies
  sl.registerLazySingleton<http.Client>(() => MockHttpServer(storage: sl()));
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());
}
