import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dubai_app_studio/core/usecases/usecase.dart';
import 'package:dubai_app_studio/features/recharge/domain/entities/history_item.dart';
import 'package:dubai_app_studio/features/recharge/domain/usecases/get_recharge_history.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final GetRechargeHistory getRechargeHistory;

  List<HistoryItem> currentHistory = [];

  HistoryBloc({required this.getRechargeHistory}) : super(HistoryInitial()) {
    on<GetRechargeHistoryEvent>(_onGetHistoryEvent);
  }

  Future<void> _onGetHistoryEvent(
      GetRechargeHistoryEvent event, Emitter<HistoryState> emit) async {
    if (currentHistory.isEmpty || event.refresh) {
      emit(HistoryLoading());

      final eitherResponse = await getRechargeHistory.call(NoParams());

      emit(
        eitherResponse.fold(
          (failure) => HistoryFailed(errorMessage: failure.errorMessage),
          (fetchedHistory) {
            currentHistory
              ..clear()
              ..addAll(fetchedHistory);
            return HistoryLoaded(history: fetchedHistory);
          },
        ),
      );
    }
  }
}
