import 'package:expense_app/main.dart';
import 'package:expense_app/model/cal_model.dart';
import 'package:expense_app/utils/colors.dart';
import 'package:expense_app/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icon.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'controller/time_controller.dart';

class DashboardHeader extends ConsumerWidget {
  const DashboardHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totals = ref.watch(totalProvider);
    final greeting = ref.watch(greetingProvider);

    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: double.infinity,
              height: 32.h,
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: AppColor.kBlackColor,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(25.sp),
                ),
              ),
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _getGreetingText(greeting),
                            style: TextStyle(
                              color: AppColor.kWhitColor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Christian Okorie',
                            style: TextStyle(
                              color: AppColor.kWhitColor,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: Adaptive.w(10),
                        height: 5.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.sp),
                          color: AppColor.kDarkGreyColor,
                        ),
                        child: LineIcon.bell(
                          color: AppColor.kWhitColor,
                          size: 18.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 180,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              width: Adaptive.w(90),
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(15.sp),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.kBlackColor.withOpacity(0.4),
                    offset: const Offset(0, 6),
                    blurRadius: 12,
                    spreadRadius: 6,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Balance',
                        style: TextStyle(
                          color: AppColor.kWhitColor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      LineIcon.horizontalEllipsis(
                        color: AppColor.kWhitColor,
                        size: 16.sp,
                      ),
                    ],
                  ),
                  Gap(0.3.h),
                  Text(
                    "\$ ${totals.grandTotal}",
                    style: TextStyle(
                      color: AppColor.kWhitColor,
                      fontSize: 18.sp,
                      letterSpacing: 1.6,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Gap(1.5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildExpenseDashBoardComponent(
                        'Income',
                        LineIcon.arrowUp(
                          size: 17.sp,
                          color: AppColor.kGreenColor,
                        ),
                        '${totals.totalIncome}',
                      ),
                      _buildExpenseDashBoardComponent(
                        'Expense',
                        LineIcon.arrowDown(
                          size: 17.sp,
                          color: AppColor.kredColor,
                        ),
                        '${totals.totalExpense}',
                      ),
                      _buildExpenseDashBoardComponent(
                        'Debt',
                        LineIcon.arrowRight(
                          size: 17.sp,
                          color: AppColor.kBlueColor,
                        ),
                        '${totals.totalDebt}',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _getGreetingText(Greeting greeting) {
    switch (greeting) {
      case Greeting.morning:
        return 'Good Morning';
      case Greeting.afternoon:
        return 'Good Afternoon';
      case Greeting.evening:
        return 'Good Evening';
      default:
        return '';
    }
  }

  Widget _buildExpenseDashBoardComponent(
      String title, Widget icon, String amount) {
    return BuildExpenseDashBoardComponent(
      title: title,
      icon: icon,
      amount: amount,
    );
  }
}
