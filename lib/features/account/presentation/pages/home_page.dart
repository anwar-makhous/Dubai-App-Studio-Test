import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dubai_app_studio/core/constants/app_constants.dart';
import 'package:dubai_app_studio/core/widgets/tap_twice_to_exit.dart';
import 'package:dubai_app_studio/features/beneficiary/presentation/blocs/beneficiaries_bloc/beneficiaries_bloc.dart';
import 'package:dubai_app_studio/features/account/presentation/blocs/account_bloc/account_bloc.dart';
import 'package:dubai_app_studio/features/account/presentation/widgets/account_info_widget.dart';
import 'package:dubai_app_studio/features/account/presentation/widgets/home_tab_bar.dart';
import 'package:dubai_app_studio/features/account/presentation/widgets/short_account_info_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<AccountBloc>().add(GetAccountInfoEvent());
    context.read<BeneficiariesBloc>().add(const GetBeneficiariesEvent());
    super.initState();
  }

  ValueNotifier<bool> showFullAccountInfoNotifier = ValueNotifier<bool>(true);

  void onSwitchToHistoryTab() {
    showFullAccountInfoNotifier.value = false;
  }

  void onSwitchToRechargeTab() {
    showFullAccountInfoNotifier.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Home Page"),
      ),
      body: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          if (state is AccountFailed) {
            return Center(
              child: Text(
                state.errorMessage,
                style: TextStyle(fontSize: AppFontSizes.small),
              ),
            );
          }
          if (state is AccountLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is AccountLoaded) {
            return SingleChildScrollView(
              child: TapTwiceToExit(
                child: Column(
                  children: [
                    ValueListenableBuilder(
                      valueListenable: showFullAccountInfoNotifier,
                      builder: (context, showFullAccountInfo, _) {
                        return AnimatedCrossFade(
                          crossFadeState: showFullAccountInfo
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                          duration: AppAnimation.duration,
                          reverseDuration: AppAnimation.duration,
                          firstCurve: AppAnimation.curve,
                          secondCurve: AppAnimation.curve,
                          sizeCurve: AppAnimation.curve,
                          firstChild: AccountInfoWidget(
                              accountInfo: state.currentAccountInfo),
                          secondChild: ShortAccountInfoWidget(
                              accountInfo: state.currentAccountInfo),
                        );
                      },
                    ),
                    HomeTabBar(
                      onSwitchToHistoryTab: onSwitchToHistoryTab,
                      onSwitchToRechargeTab: onSwitchToRechargeTab,
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
