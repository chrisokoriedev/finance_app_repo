import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'colors.dart';

class BuildExpenseDashBoardComponent extends StatelessWidget {
  final String title;
  final Widget icon;
  final String amount;

  const BuildExpenseDashBoardComponent({
    super.key,
    required this.title,
    required this.icon,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
                radius: 13.sp,
                backgroundColor: AppColor.kWhitColor,
                child: icon),
            Gap(2.w),
            Text(
              title,
              style: TextStyle(
                  color: AppColor.kWhitColor,
                  fontSize: 13.sp,
                  letterSpacing: 1.6,
                  fontWeight: FontWeight.w300),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 21.sp),
          child: Text(
            '\$ $amount',
            style: TextStyle(
                color: AppColor.kWhitColor,
                fontSize: 15.sp,
                letterSpacing: 1.6,
                fontWeight: FontWeight.w600),
          ),
        )
      ],
    );
  }
}
