import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:dubai_app_studio/core/error/error.dart';
import 'package:dubai_app_studio/features/recharge/domain/entities/history_item.dart';
import 'package:dubai_app_studio/features/recharge/domain/usecases/get_recharge_history.dart';
import 'package:dubai_app_studio/features/recharge/presentation/blocs/history_bloc/history_bloc.dart';

import 'history_bloc_test.mocks.dart';

@GenerateMocks([
  GetRechargeHistory,
])
void main() {
  late HistoryBloc bloc;
  late MockGetRechargeHistory mockGetRechargeHistory;

  final tHistoryItems = [
    HistoryItem(
      name: "Sarah",
      phoneNumber: "551231237",
      amount: 50.00,
      date: DateTime(24, 6, 15),
    ),
    HistoryItem(
      name: "James",
      phoneNumber: "557654321",
      amount: 25.00,
      date: DateTime(24, 6, 17),
    ),
    HistoryItem(
      name: "Sarah",
      phoneNumber: "551231237",
      amount: 100.00,
      date: DateTime(24, 6, 19),
    ),
  ];

  setUp(() {
    mockGetRechargeHistory = MockGetRechargeHistory();
    bloc = HistoryBloc(getRechargeHistory: mockGetRechargeHistory);
  });

  blocTest<HistoryBloc, HistoryState>(
    'emits [HistoryLoading, HistoryLoaded] when GetRechargeHistoryEvent is added.',
    build: () => bloc,
    act: (bloc) {
      when(mockGetRechargeHistory.call(any))
          .thenAnswer((_) async => Right(tHistoryItems));
      bloc.add(const GetRechargeHistoryEvent(refresh: true));
    },
    expect: () => <HistoryState>[
      HistoryLoading(),
      HistoryLoaded(
        history: tHistoryItems,
      ),
    ],
  );

  blocTest<HistoryBloc, HistoryState>(
    'emits [HistoryLoading, HistoryFailed] when GetRechargeHistoryEvent is added and GetRechargeHistory fails.',
    build: () => bloc,
    act: (bloc) {
      when(mockGetRechargeHistory.call(any))
          .thenAnswer((_) async => const Left(UnknownFailure()));
      bloc.add(const GetRechargeHistoryEvent(refresh: true));
    },
    expect: () => <HistoryState>[
      HistoryLoading(),
      const HistoryFailed(errorMessage: FailureMessages.unknown),
    ],
  );
}
