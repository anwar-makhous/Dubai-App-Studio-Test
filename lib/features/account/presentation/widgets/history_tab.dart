import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:dubai_app_studio/core/constants/app_constants.dart';
import 'package:dubai_app_studio/features/account/presentation/widgets/history_item_card.dart';
import 'package:dubai_app_studio/features/recharge/presentation/blocs/history_bloc/history_bloc.dart';

class HistoryTab extends StatefulWidget {
  const HistoryTab({super.key});

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  @override
  void initState() {
    context.read<HistoryBloc>().add(const GetRechargeHistoryEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryState>(
      builder: (context, state) {
        if (state is HistoryLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is HistoryFailed) {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(40.r),
            child: Text(
              state.errorMessage,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: AppFontSizes.medium),
            ),
          );
        }
        if (state is HistoryLoaded) {
          if (state.history.isEmpty) {
            return Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(40.r),
              child: Text(
                "No history yet\n\ngo to recharge tab and start adding beneficiaries so you can use our services!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: AppFontSizes.medium),
              ),
            );
          }
          return ListView.separated(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            itemCount: state.history.length,
            separatorBuilder: (context, _) => SizedBox(height: 10.h),
            itemBuilder: (context, index) => HistoryItemCard(
              historyItem: state.history[index],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
