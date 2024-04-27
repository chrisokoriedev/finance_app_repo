import 'package:expense_app/domain/cal.dart';
import 'package:expense_app/utils/colors.dart';
import 'package:expense_app/utils/const.dart';
import 'package:expense_app/utils/text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icon.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:timeago/timeago.dart' as timeago;

class ExpenseListBuilder extends HookConsumerWidget {
  final List data;
  final bool showDateTIme;

  final int childCount;
  const ExpenseListBuilder({
    super.key,
    required this.data,
    this.showDateTIme = true,
    required this.childCount,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).colorScheme;

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: childCount,
        (context, index) {
          if (data.isEmpty) {
            return const NoDataView();
          }
          var history = data[index];
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
            key: ObjectKey(history),
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
                  backgroundColor: theme.onPrimary,
                  title: TextWigdet(
                      text: 'Confirm Delete',
                      color: theme.primary,
                      fontSize: 16.sp,
                      letterSpacing: 1.3,
                      fontWeight: FontWeight.w600),
                  content: TextWigdet(
                      text: 'Are you sure you want to delete this item?',
                      color: theme.primary,
                      fontSize: 16.sp,
                      letterSpacing: 1.3,
                      fontWeight: FontWeight.w600),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text('Cancel',
                          style: TextStyle(
                              fontSize: 15.sp,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w600)),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: Text(
                        'Delete',
                        style: TextStyle(
                            fontSize: 15.sp,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              );
              return confirm;
            },
            onDismissed: (direction) {
              String expenseName = history.name;
              ref
                  .read(deleteExpenseProvider.notifier)
                  .state
                  .deleteExpense(expenseName);
            },
            child: ListTile(
              title: Row(
                children: [
                  TextWigdet(
                      text: '${history.expenseType}\tfor\t${history.name}',
                      color: theme.primary,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600),
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
                  showDateTIme
                      ? Text(
                          timeago.format(history.dateTime),
                          style: TextStyle(
                              color: AppColor.kGreyColor.shade500,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
              leading: iconData,
              trailing: Text(
                history.amount.toString(),
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
            ),
          );
        },
      ),
    );
  }
}
