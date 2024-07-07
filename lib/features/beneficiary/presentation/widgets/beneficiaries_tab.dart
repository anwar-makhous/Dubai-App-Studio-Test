import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:dubai_app_studio/core/constants/app_constants.dart';
import 'package:dubai_app_studio/features/beneficiary/presentation/blocs/beneficiaries_bloc/beneficiaries_bloc.dart';
import 'package:dubai_app_studio/features/beneficiary/presentation/widgets/add_beneficiary_button.dart';
import 'package:dubai_app_studio/features/beneficiary/presentation/widgets/beneficiary_card.dart';

class BeneficiariesTab extends StatefulWidget {
  const BeneficiariesTab({super.key});

  @override
  State<BeneficiariesTab> createState() => _BeneficiariesTabState();
}

class _BeneficiariesTabState extends State<BeneficiariesTab> {
  @override
  void initState() {
    context.read<BeneficiariesBloc>().add(const GetBeneficiariesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BeneficiariesBloc, BeneficiariesState>(
      builder: (context, state) {
        if (state is BeneficiariesLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is BeneficiariesFailed) {
          return Center(
            child: Text(
              state.errorMessage,
              style: TextStyle(fontSize: AppFontSizes.small),
            ),
          );
        }
        if (state is BeneficiariesLoaded) {
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            itemCount: state.beneficiaries.length + 1,
            separatorBuilder: (context, _) => SizedBox(width: 10.w),
            itemBuilder: (context, index) {
              if (index < state.beneficiaries.length) {
                return BeneficiaryCard(beneficiary: state.beneficiaries[index]);
              }
              if (state.beneficiaries.length <
                  AppConfig.maxBeneficiariesCount) {
                return const AddBeneficiaryButton();
              }
              return const SizedBox.shrink();
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
