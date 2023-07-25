import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../utils/colors.dart';
import '../HeaderDashboard/header.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(height: 45.h, child: const DashboardHeader()),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(15.sp),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Transaction History',
                    style: TextStyle(
                        color: AppColor.kBlackColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'See all',
                    style: TextStyle(
                        color: AppColor.kGreyColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              )
            ]),
          ),
        ),
      ],
    ));
  }
}
