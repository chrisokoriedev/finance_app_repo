import 'package:expense_app/main.dart';
import 'package:expense_app/model/create_expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:line_icons/line_icon.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../utils/colors.dart';
import '../HeaderDashboard/header.dart';

final itemProvider = StateProvider((ref) => boxUse.values.toList());

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(itemProvider);
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
            childCount: boxUse.length,
            (context, index) {
              var history = boxUse.values.toList()[index];
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
                      backgroundColor: AppColor.kWhitColor,
                      title: const Text('Confirm Delete'),
                      content: const Text(
                          'Are you sure you want to delete this item?'),
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
                  subtitle: Text(
                    history.explain,
                    style: TextStyle(
                        color: AppColor.kDarkGreyColor,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  leading: history.expenseType == "Income"
                      ? LineIcon.wallet(
                          color: AppColor.kGreenColor,
                          size: 18.sp,
                        )
                      : LineIcon.alternateWavyMoneyBill(
                          color: AppColor.kredColor,
                          size: 18.sp,
                        ),
                  trailing: Text(history.amount),
                ),
              );
            },
          ))
        ],
      ),
    ));
  }
}
