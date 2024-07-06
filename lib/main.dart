import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:dubai_app_studio/features/beneficiary/presentation/blocs/beneficiaries_bloc/beneficiaries_bloc.dart';
import 'package:dubai_app_studio/features/home/presentation/blocs/home_bloc/home_bloc.dart';
import 'package:dubai_app_studio/features/home/presentation/pages/home_page.dart';
import 'package:dubai_app_studio/features/recharge/presentation/blocs/history_bloc/history_bloc.dart';
import 'package:dubai_app_studio/features/recharge/presentation/blocs/recharge_bloc/recharge_bloc.dart';
import 'package:dubai_app_studio/injection_container.dart';

void main() {
  runApp(const MyApp());
  initServiceLocator();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      builder: (context, _) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<HomeBloc>(create: (context) => sl<HomeBloc>()),
            BlocProvider<HistoryBloc>(create: (context) => sl<HistoryBloc>()),
            BlocProvider<RechargeBloc>(create: (context) => sl<RechargeBloc>()),
            BlocProvider<BeneficiariesBloc>(
                create: (context) => sl<BeneficiariesBloc>()),
          ],
          child: MaterialApp(
            title: 'DA Studio',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const HomePage(),
          ),
        );
      },
    );
  }
}
