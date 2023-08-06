import 'dart:math';

import 'package:expense_app/main.dart';
import 'package:expense_app/model/create_expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:line_icons/line_icon.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../utils/colors.dart';
import '../HeaderDashboard/header.dart';

final itemProvider = StateProvider((ref) => boxUse.values.toList());

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

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
                    ),
                  ]),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: min(boxUse.length, 5),
              (context, index) {
                var history = boxUse.values.toList()[index];
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
                return Dismissible(
                  background: Container(
                    color: AppColor.kredColor,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 16.0.sp),
                        child: Icon(
                          Icons.delete,
                          size: 18.sp,
                          color: AppColor.kWhitColor,
                        ),
                      ),
                    ),
                  ),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (direction) async {
                    bool confirm = await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        surfaceTintColor: AppColor.kBlackColor,
                        backgroundColor: AppColor.kWhitColor,
                        title: Text(
                          'Confirm Delete',
                          style: TextStyle(
                              color: AppColor.kBlackColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        content: Text(
                          'Are you sure you want to delete this item?',
                          style: TextStyle(
                              color: AppColor.kDarkGreyColor,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text('Delete'),
                          ),
                        ],
                      ),
                    );
                    return confirm;
                  },
                  onDismissed: (direction) {
                    history.delete();
                  },
                  key: ObjectKey(history),
                  child: ListTile(
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
                      history.amount,
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w600),
                    ),
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
