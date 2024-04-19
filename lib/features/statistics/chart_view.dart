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
        data: (data) {
          List<CreateExpenseModel> incomeData =
              data.where((expense) => expense.expenseType == "Income").toList();
          List<CreateExpenseModel> expenseData = data
              .where((expense) => expense.expenseType == "Expense")
              .toList();
          List<CreateExpenseModel> debtData =
              data.where((expense) => expense.expenseType == "Debt").toList();
          return SizedBox(
            width: double.infinity,
            height: 35.h,
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              legend: const Legend(isVisible: true, width: '35'),
              series: <SplineSeries<CreateExpenseModel, String>>[
                SplineSeries(
                  name: 'Income',
                  color: AppColor.kGreenColor,
                  width: 1.w,
                  dataSource: incomeData,
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                  xValueMapper: (CreateExpenseModel expense, _) {
                    var exp=DateTime.parse(expense.dateTime);
                    return switch (selectDatetime) {
                    0 => exp.day.toString(),
                    1 => exp.weekday.toString(),
                    2 => exp.month.toString(),
                    3 => exp.year.toString(),
                    _ => exp.year.toString()
                  };
                  },
                  yValueMapper: (CreateExpenseModel sales, _) => sales.amount,
                ),
                SplineSeries(
                  name: 'Expense',
                  color: AppColor.kredColor,
                  width: 1.w,
                  dataSource: expenseData,
                  xValueMapper: (CreateExpenseModel expense, _) {
                    var exp=DateTime.parse(expense.dateTime);
                    return switch (selectDatetime) {
                    0 => exp.day.toString(),
                    1 => exp.weekday.toString(),
                    2 => exp.month.toString(),
                    3 => exp.year.toString(),
                    _ => exp.year.toString()
                  };
                  },
                  yValueMapper: (CreateExpenseModel sales, _) => sales.amount,
                ),
                SplineSeries(
                  name: 'Debt',
                  color: AppColor.kBlueColor,
                  width: 1.w,
                  dataSource: debtData,
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                  xValueMapper: (CreateExpenseModel expense, _) {
                    var exp=DateTime.parse(expense.dateTime);
                    return switch (selectDatetime) {
                    0 => exp.day.toString(),
                    1 => exp.weekday.toString(),
                    2 => exp.month.toString(),
                    3 => exp.year.toString(),
                    _ => exp.year.toString()
                  };
                  },
                  yValueMapper: (CreateExpenseModel sales, _) => sales.amount,
                ),
              ],
              annotations: const [],
            ),
          );
        },
        error: (_, __) => const Text('error '),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}
