import 'package:expense_app/features/statistics/statistics.dart';
import 'package:expense_app/model/create_expense.dart';
import 'package:expense_app/provider/item_provider.dart';
import 'package:expense_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartComponent extends HookConsumerWidget {
  const ChartComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemProvider = ref.watch(cloudItemsProvider);
    final selectDatetime = ref.watch(selectedTabProvider);
    return itemProvider.when(
      data: (dataExpense) {
        List<CreateExpenseModel> data = dataExpense
          ..sort(a,b)..remove(true);
        List<CreateExpenseModel> incomeData =
            data.where((expense) => expense.expenseType == "Income").toList();
        List<CreateExpenseModel> expenseData =
            data.where((expense) => expense.expenseType == "Expense").toList();
        List<CreateExpenseModel> debtData =
            data.where((expense) => expense.expenseType == "Debt").toList();
        return SizedBox(
          width: double.infinity,
          height: 35.h,
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            series: <SplineSeries<CreateExpenseModel, String>>[
              SplineSeries(
                color: AppColor.kGreenColor,
                width: 1.w,
                dataSource: incomeData,
                dataLabelSettings: const DataLabelSettings(isVisible: true),
                xValueMapper: (CreateExpenseModel expense, _) =>
                    switch (selectDatetime) {
                  0 => expense.dateTime.day.toString(),
                  1 => expense.dateTime.weekday.toString(),
                  2 => expense.dateTime.month.toString(),
                  3 => expense.dateTime.year.toString(),
                  _ => expense.dateTime.year.toString()
                },
                yValueMapper: (CreateExpenseModel sales, _) => sales.amount,
              ),
              SplineSeries(
                color: AppColor.kredColor,
                width: 1.w,
                dataSource: [...expenseData, ...debtData],
                dataLabelSettings: const DataLabelSettings(isVisible: true),
                xValueMapper: (CreateExpenseModel expense, _) =>
                    switch (selectDatetime) {
                  0 => expense.dateTime.day.toString(),
                  1 => expense.dateTime.weekday.toString(),
                  2 => expense.dateTime.month.toString(),
                  3 => expense.dateTime.year.toString(),
                  _ => expense.dateTime.year.toString()
                },
                yValueMapper: (CreateExpenseModel sales, _) {
                  if (sales.expenseType == 'Expense') {
                    return sales.amount;
                  } else if (sales.expenseType == 'Debt') {
                    return sales.amount;
                  }
                  return sales.amount;
                },
              ),
            ],
          ),
        );
      },
      error: (_, __) => const Center(child: Text('Error')),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
