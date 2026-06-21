import 'dart:math';

import 'package:expense_app/core/domain/cal.dart';
import 'package:expense_app/core/model/create_expense.dart';
import 'package:expense_app/core/provider/item_provider.dart';
import 'package:expense_app/core/theme/neu_theme.dart';
import 'package:expense_app/core/utils/colors.dart';
import 'package:expense_app/core/utils/const.dart';
import 'package:expense_app/core/utils/string_app.dart';
import 'package:expense_app/core/utils/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:line_icons/line_icon.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'chart_view.dart';

final selectedTabProvider = StateProvider<int>((ref) => 0);
final expenseItemTypeProvider =
    StateProvider<String>((ref) => AppString.income);

/// Labels for the statistics time-range tabs.
const List<String> dayType = ['Day', 'Week', 'Month', 'Year'];

class Statistics extends ConsumerWidget {
  final PageController pageController;
  const Statistics(this.pageController, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final neu = context.neu;
    final selectedTab = ref.watch(selectedTabProvider);
    final itemProvider = ref.watch(cloudItemsProvider);
    final totals = ref.watch(totalsProvider);

    return PopScope(
      canPop: false,
      onPopInvoked: (value) {
        pageController.jumpToPage(0);
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(1.5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Statistics',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.tune_outlined,
                        color: neu.textSecondary,
                        size: 18.sp,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                Gap(2.h),
                NeuSegmented(
                  segments: const ['Day', 'Week', 'Month', 'Year'],
                  selectedIndex: selectedTab,
                  activeColor: neu.primary,
                  onChanged: (index) {
                    ref.read(selectedTabProvider.notifier).state = index;
                  },
                ),
                Gap(2.5.h),
                itemProvider.when(
                  loading: () => const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  error: (err, stack) => Expanded(
                    child: Center(
                      child: Text(
                        'Something went wrong',
                        style: TextStyle(color: neu.textSecondary),
                      ),
                    ),
                  ),
                  data: (data) {
                    final chartData = [
                      ChartData('Income', totals.totalIncome, neu.income),
                      ChartData('Expense', totals.totalExpense, neu.expense),
                      ChartData('Debt', totals.totalDebt, neu.debt),
                    ];

                    final topCategories = _calculateTopCategories(data);

                    return Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Donut Chart Card
                            Container(
                              padding: EdgeInsets.all(16.sp),
                              decoration: BoxDecoration(
                                color: neu.surface,
                                borderRadius: BorderRadius.circular(22.sp),
                                boxShadow: neu.raised,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: SizedBox(
                                      height: 16.h,
                                      child: SfCircularChart(
                                        margin: EdgeInsets.zero,
                                        annotations: <CircularChartAnnotation>[
                                          CircularChartAnnotation(
                                            widget: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  _compact(totals.totalExpense),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  'spent',
                                                  style: TextStyle(
                                                    color: neu.textSecondary,
                                                    fontSize: 11.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                        series: <CircularSeries>[
                                          DoughnutSeries<ChartData, String>(
                                            dataSource: chartData,
                                            xValueMapper: (ChartData d, _) => d.x,
                                            yValueMapper: (ChartData d, _) => d.y,
                                            pointColorMapper: (ChartData d, _) => d.color,
                                            innerRadius: '75%',
                                            radius: '100%',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        _legendItem(neu.income, 'Income', totals.totalIncome, neu),
                                        Gap(1.2.h),
                                        _legendItem(neu.expense, 'Expense', totals.totalExpense, neu),
                                        Gap(1.2.h),
                                        _legendItem(neu.debt, 'Debt', totals.totalDebt, neu),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Gap(3.h),
                            Text(
                              'Top categories',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Gap(1.5.h),
                            if (topCategories.isEmpty)
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.h),
                                child: Center(
                                  child: Text(
                                    'No expenses recorded yet',
                                    style: TextStyle(
                                      color: neu.textSecondary,
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                ),
                              )
                            else
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: topCategories.length,
                                itemBuilder: (context, idx) {
                                  return _categoryProgressBar(
                                      topCategories[idx], totals.totalExpense, neu);
                                },
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _legendItem(Color color, String label, double value, NeuColors neu) {
    return Row(
      children: [
        Container(
          width: 10.sp,
          height: 10.sp,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3.sp),
          ),
        ),
        Gap(2.5.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: neu.textSecondary,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            Gap(0.2.h),
            Text(
              _money(value),
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _categoryProgressBar(CategorySpend cat, double totalExpense, NeuColors neu) {
    final ratio = totalExpense > 0 ? (cat.amount / totalExpense).clamp(0.0, 1.0) : 0.0;
    Color barColor = neu.primary;
    final nameLower = cat.category.toLowerCase();
    if (nameLower.contains('grocer') || nameLower.contains('food') || nameLower.contains('house') || nameLower.contains('general')) {
      barColor = neu.expense; // coral
    } else if (nameLower.contains('transport') || nameLower.contains('data') || nameLower.contains('cloth')) {
      barColor = neu.debt; // slate blue
    } else if (nameLower.contains('eat') || nameLower.contains('cafe')) {
      barColor = neu.primary; // green
    } else {
      barColor = neu.accent; // gold
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                cat.category,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.5.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                _money(cat.amount),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.5.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Gap(0.8.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.sp),
            child: Container(
              height: 6.dp,
              width: double.infinity,
              color: Colors.black.withOpacity(0.2),
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: ratio,
                child: Container(
                  color: barColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<CategorySpend> _calculateTopCategories(List<CreateExpenseModel> expenses) {
    final Map<String, double> categorySums = {};
    for (final item in expenses) {
      if (item.expenseType == 'Expense') {
        final cat = item.expenseSubList == '..' ? 'General' : item.expenseSubList;
        categorySums[cat] = (categorySums[cat] ?? 0) + item.amount;
      }
    }
    final sorted = categorySums.entries.map((e) => CategorySpend(e.key, e.value)).toList()
      ..sort((a, b) => b.amount.compareTo(a.amount));
    return sorted;
  }

  String _money(num v) => '₦${NumberFormat('#,##0').format(v)}';

  String _compact(num v) =>
      NumberFormat.compactCurrency(symbol: '₦', decimalDigits: 0).format(v);
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}

class CategorySpend {
  final String category;
  final double amount;
  CategorySpend(this.category, this.amount);
}
