import 'package:expense_app/model/create_expense.dart';
import 'package:expense_app/provider/item_provider.dart';
import 'package:expense_app/utils/colors.dart';
import 'package:expense_app/utils/format_date.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icon.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ViewAllExpense extends HookConsumerWidget {
  const ViewAllExpense({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyProvider = ref.watch(itemBoxProvider);

    return historyProvider.when(
      skipLoadingOnReload: true,
      error: (_, __) => const Text('Something went wrong'),
      loading: () => const CircularProgressIndicator(color: Colors.red),
      data: (data) {
        List<CreateExpenseModel> expenseData = data.values.toList();
        Map<DateTime, List<CreateExpenseModel>> groupedExpenses = {};

        for (var expense in expenseData) {
          DateTime date = DateTime(expense.dateTime.year,
              expense.dateTime.month, expense.dateTime.day);
          if (!groupedExpenses.containsKey(date)) {
            groupedExpenses[date] = [];
          }
          groupedExpenses[date]!.add(expense);
        }

        return Scaffold(
          appBar: AppBar(
              title: Text(
            'View All Expenses',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
          )),
          body: ListView.builder(
            itemCount: groupedExpenses.length,
            itemBuilder: (context, index) {
              var date = groupedExpenses.keys.elementAt(index);
              var expenses = groupedExpenses[date] ?? [];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      formatDate(date),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: expenses.length,
                    itemBuilder: (context, idx) {
                      var history = expenses[idx];
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
                          ],
                        ),
                        leading: iconData,
                        trailing: Text(
                          history.amount.toString(),
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.w600),
                        ),
                      );
                    },
                  ),
                  const Divider(),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
