import 'package:expense_app/domain/cal.dart';
import 'package:expense_app/model/create_expense.dart';
import 'package:expense_app/provider/item_provider.dart';
import 'package:expense_app/utils/colors.dart';
import 'package:expense_app/utils/const.dart';
import 'package:expense_app/utils/format_date.dart';
import 'package:expense_app/utils/string_app.dart';
import 'package:expense_app/utils/text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icon.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ViewExpensesTimeline extends HookConsumerWidget {
  const ViewExpensesTimeline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyProvider = ref.watch(cloudItemsProvider);
    final theme = Theme.of(context).colorScheme;
    return historyProvider.when(
      skipLoadingOnReload: true,
      error: (_, __) => const Text('Something went wrong'),
      loading: () => const CircularProgressIndicator(color: Colors.red),
      data: (data) {
          var dataNew = data..sort((a, b) => b.dateTime.compareTo(a.dateTime));
        
        List<CreateExpenseModel> expenseData = dataNew.toList();

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
              title: TextWigdet(
                  text: AppString.viewTimeline,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600)),
          body: expenseData.isEmpty
              ? const NoDataView()
              : ListView.builder(
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
                                        fontWeight: FontWeight.w600),
                                    content: TextWigdet(
                                        text:
                                            'Are you sure you want to delete this item?',
                                        color: theme.primary,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500),
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
                                int expense = expenses.indexOf(history);
                                ref
                                    .read(deleteExpenseProvider.notifier)
                                    .state
                                    .deleteExpense(expense);
                              },
                              child: ListTile(
                                title: Row(
                                  children: [
                                    TextWigdet(
                                        text:
                                            '${history.expenseType}\tfor\t${history.name}',
                                        color: theme.primary,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600),
                                  ],
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWigdet(
                                        text: history.explain,
                                        color: theme.primary,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w600),
                                  ],
                                ),
                                leading: iconData,
                                trailing: TextWigdet(
                                    text: history.amount.toString(),
                                    fontSize: 18.sp,
                                    color: theme.primary,
                                    fontWeight: FontWeight.w600),
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
