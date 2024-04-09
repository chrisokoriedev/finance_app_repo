import 'dart:math';
import 'package:expense_app/main.dart';
import 'package:expense_app/model/create_expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:line_icons/line_icon.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../utils/colors.dart';
import '../HeaderDashboard/header.dart';

class HomePage extends ConsumerWidget {
  final VoidCallback pageSelected;

  const HomePage({super.key, required this.pageSelected});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: ValueListenableBuilder(
      valueListenable: boxUse.listenable(),
      builder:
          (BuildContext context, Box<CreateExpenseModel> box, Widget? child) =>
              CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(height: 45.h, child: const DashboardHeader()),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recent History',
                          style: TextStyle(
                              color: AppColor.kBlackColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500),
                        ),
                        GestureDetector(
                          onTap: pageSelected,
                          child: Text(
                            'See all',
                            style: TextStyle(
                                color: AppColor.kGreyColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: boxUse.isNotEmpty ? min(boxUse.length, 5) : 1,
              (context, index) {
                List<CreateExpenseModel> sortedData = boxUse.values.toList()
                  ..sort((a, b) => b.dateTime.compareTo(a.dateTime));
                if (boxUse.isEmpty) {
                  return ListTile(
                    title: Column(
                      children: [
                        Gap(5.h),
                        Image.asset(
                          'assets/gifs/coming_soon.gif',
                          width: 70.w,
                        ),
                        Text(
                          'No items to display',
                          style: TextStyle(
                            color: AppColor.kDarkGreyColor,
                            fontSize: 15.sp,
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                var history = sortedData[index];
                Icon iconData;
                if (history.expenseType == "Income") {
                  iconData = LineIcon.wallet(
                    size: 18.sp,
                    color: AppColor.kGreenColor,
                  );
                } else if (history.expenseType == "Expense") {
                  iconData = LineIcon.alternateWavyMoneyBill(
                    size: 18.sp,
                    color: AppColor.kredColor,
                  );
                } else {
                  iconData = LineIcon.alternateWavyMoneyBill(
                    size: 18.sp,
                    color: AppColor.kBlueColor,
                  );
                }
                return ListTile(
                  title: Row(
                    children: [
                      Text(
                        '${history.expenseType}\tfor\t${history.name}',
                        style: TextStyle(
                            color: AppColor.kDarkGreyColor,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        history.explain,
                        style: TextStyle(
                            color: AppColor.kDarkGreyColor,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        timeago.format(history.dateTime),
                        style: TextStyle(
                            color: AppColor.kGreyColor.shade500,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  leading: iconData,
                  trailing: Text(
                    history.amount.toString(),
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}
