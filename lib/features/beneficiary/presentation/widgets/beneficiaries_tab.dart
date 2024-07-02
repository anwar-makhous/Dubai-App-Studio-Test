import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:dubai_app_studio/features/beneficiary/domain/entities/beneficiary.dart';
import 'package:dubai_app_studio/features/beneficiary/presentation/widgets/beneficiary_card.dart';

class BeneficiariesTab extends StatelessWidget {
  const BeneficiariesTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      itemCount: dummyBeneficiaries.length,
      separatorBuilder: (context, _) => SizedBox(width: 10.w),
      itemBuilder: (context, index) =>
          BeneficiaryCard(beneficiary: dummyBeneficiaries[index]),
    );
  }
}
