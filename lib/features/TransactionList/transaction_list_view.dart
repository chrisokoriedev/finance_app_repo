import 'package:expense_app/main.dart';
import 'package:expense_app/model/create_expense.dart';
import 'package:expense_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:line_icons/line_icon.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:table_calendar/table_calendar.dart';

class TransactionListView extends StatelessWidget {
  const TransactionListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.sp),
      child: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2001, 10, 16),
            lastDay: DateTime.utc(2060, 3, 14),
            focusedDay: DateTime.now(),
            onDaySelected: (selectedDay, focusedDay) {
              List<CreateExpenseModel> expensesForSelectedDate = boxUse.values
                  .toList()
                  .where((expense) =>
                      expense.dateTime.year == selectedDay.year &&
                      expense.dateTime.month == selectedDay.month &&
                      expense.dateTime.day == selectedDay.day)
                  .toList();

              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: boxUse.listenable(),
                  builder: (BuildContext context, Box<CreateExpenseModel> box,
                      Widget? child) {
                    return CustomScrollView(
                      slivers: [
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            childCount: expensesForSelectedDate.length,
                            (context, index) {
                              var history = expensesForSelectedDate[index];
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
                                          onPressed: () =>
                                              Navigator.pop(context, false),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, true),
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
                                    history.amount.toString(),
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
