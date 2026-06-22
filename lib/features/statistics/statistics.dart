import 'package:expense_app/core/domain/cal.dart';
import 'package:expense_app/core/model/create_expense.dart';
import 'package:expense_app/core/provider/item_provider.dart';
import 'package:expense_app/core/theme/neu_theme.dart';
import 'package:expense_app/core/utils/text.dart';
import 'package:expense_app/core/widgets/neu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

final selectedPeriodTabProvider = StateProvider.autoDispose<int>(
    (ref) => 1); // 0: Daily, 1: Weekly, 2: Monthly, 3: Yearly

class Statistics extends ConsumerWidget {
  final PageController pageController;
  const Statistics(this.pageController, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final neu = context.neu;
    final itemProvider = ref.watch(cloudItemsProvider);
    final totals = ref.watch(totalsProvider);
    final selectedPeriodTab = ref.watch(selectedPeriodTabProvider);

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
                      'Statics',
                      style: TextStyle(
                        color: neu.textPrimary,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.more_horiz,
                        color: neu.textSecondary,
                        size: 18.sp,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                Gap(1.5.h),
                // Combined Tab Selector (Daily, Weekly, Monthly, Yearly)
                NeuSegmented(
                  segments: const ['Daily', 'Weekly', 'Monthly', 'Yearly'],
                  selectedIndex: selectedPeriodTab,
                  activeColor: neu.primary,
                  onChanged: (index) {
                    ref.read(selectedPeriodTabProvider.notifier).state = index;
                  },
                ),
                Gap(2.5.h),
                // Total Balance with Trend Indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: 'Total Balance',
                          color: neu.textSecondary,
                          fontSize: 12.5.sp,
                        ),
                        Gap(0.4.h),
                        TextWidget(
                          text: _money(totals.grandTotal),
                          color: neu.textPrimary,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.sp, vertical: 4.sp),
                      decoration: BoxDecoration(
                        color: neu.primary.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(20.sp),
                        border: Border.all(
                          color: neu.primary.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.trending_up,
                            color: neu.primary,
                            size: 13.sp,
                          ),
                          Gap(1.w),
                          TextWidget(
                            text: '+2.4%',
                            color: neu.primary,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Gap(2.5.h),
                // Dynamic Data Section
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
                    // Compute chart bar points and metric values dynamically
                    final barData = _calculateBarData(data, selectedPeriodTab);
                    final periodTotals = _calculatePeriodTotals(data, selectedPeriodTab);
                    final topCategories = _calculatePeriodTopCategories(data, selectedPeriodTab);

                    return Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Custom Vertical Bar Chart Container
                            Container(
                              padding: EdgeInsets.all(16.sp),
                              height: 25.h,
                              decoration: BoxDecoration(
                                color: neu.surface,
                                borderRadius: BorderRadius.circular(22.sp),
                                boxShadow: neu.raised,
                              ),
                              child: SfCartesianChart(
                                plotAreaBorderWidth: 0,
                                margin: EdgeInsets.zero,
                                primaryXAxis: CategoryAxis(
                                  majorGridLines:
                                      const MajorGridLines(width: 0),
                                  majorTickLines: const MajorTickLines(size: 0),
                                  axisLine: const AxisLine(width: 0),
                                  labelStyle: TextStyle(
                                    color: neu.textSecondary,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                primaryYAxis: NumericAxis(
                                  isVisible: false,
                                  majorGridLines:
                                      const MajorGridLines(width: 0),
                                ),
                                series: <ColumnSeries<MonthlyBarData, String>>[
                                  ColumnSeries<MonthlyBarData, String>(
                                    dataSource: barData,
                                    xValueMapper: (MonthlyBarData d, _) =>
                                        d.label,
                                    yValueMapper: (MonthlyBarData d, _) =>
                                        d.value,
                                    pointColorMapper: (MonthlyBarData d, _) => d
                                            .isActive
                                        ? neu.primary
                                        : neu.textSecondary.withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(8),
                                    width: 0.32,
                                    animationDuration: 600,
                                  ),
                                ],
                              ),
                            ),
                            Gap(3.h),
                            // Side-by-Side Dynamic Withdrawal & Deposit Metrics
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(15.sp),
                                    decoration: BoxDecoration(
                                      color: neu.surface,
                                      borderRadius:
                                          BorderRadius.circular(18.sp),
                                      boxShadow: neu.raised,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextWidget(
                                              text: 'Total Withdrawal',
                                              color: neu.textSecondary,
                                              fontSize: 12.sp,
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: neu.expense
                                                    .withOpacity(0.12),
                                              ),
                                              child: Icon(
                                                Icons.arrow_downward,
                                                color: neu.expense,
                                                size: 14.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Gap(1.h),
                                        TextWidget(
                                          text: _money(periodTotals.withdrawal),
                                          color: neu.textPrimary,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Gap(4.w),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(15.sp),
                                    decoration: BoxDecoration(
                                      color: neu.surface,
                                      borderRadius:
                                          BorderRadius.circular(18.sp),
                                      boxShadow: neu.raised,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextWidget(
                                              text: 'Total Deposit',
                                              color: neu.textSecondary,
                                              fontSize: 12.sp,
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: neu.income
                                                    .withOpacity(0.12),
                                              ),
                                              child: Icon(
                                                Icons.arrow_upward,
                                                color: neu.income,
                                                size: 14.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Gap(1.h),
                                        TextWidget(
                                          text: _money(periodTotals.deposit),
                                          color: neu.textPrimary,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Gap(3.h),
                            Text(
                              'Top categories',
                              style: TextStyle(
                                color: neu.textPrimary,
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
                                    'No expenses recorded yet for this period',
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
                                      topCategories[idx],
                                      periodTotals.withdrawal,
                                      neu);
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

  // Calculate bar data points dynamically based on the active period key
  List<MonthlyBarData> _calculateBarData(
      List<CreateExpenseModel> expenses, int periodIndex) {
    final now = DateTime.now();
    final List<MonthlyBarData> list = [];

    if (periodIndex == 0) {
      // DAILY: Last 7 days
      final formatter = DateFormat('E');
      for (int i = 6; i >= 0; i--) {
        final targetDate = now.subtract(Duration(days: i));
        final label = formatter.format(targetDate);
        double sum = 0;
        for (final exp in expenses) {
          if (exp.expenseType == 'Expense' &&
              exp.dateTime.year == targetDate.year &&
              exp.dateTime.month == targetDate.month &&
              exp.dateTime.day == targetDate.day) {
            sum += exp.amount;
          }
        }
        list.add(MonthlyBarData(label, sum, i == 0));
      }
    } else if (periodIndex == 1) {
      // WEEKLY: Last 4 weeks
      for (int i = 3; i >= 0; i--) {
        final startOfWeek =
            now.subtract(Duration(days: (i * 7) + now.weekday - 1));
        final endOfWeek = startOfWeek.add(const Duration(days: 6));
        final label = i == 0 ? 'This Wk' : 'Wk -$i';
        double sum = 0;
        for (final exp in expenses) {
          if (exp.expenseType == 'Expense' &&
              exp.dateTime
                  .isAfter(startOfWeek.subtract(const Duration(seconds: 1))) &&
              exp.dateTime
                  .isBefore(endOfWeek.add(const Duration(seconds: 1)))) {
            sum += exp.amount;
          }
        }
        list.add(MonthlyBarData(label, sum, i == 0));
      }
    } else if (periodIndex == 2) {
      // MONTHLY: Last 6 months
      final formatter = DateFormat('MMM');
      for (int i = 5; i >= 0; i--) {
        final targetMonth = DateTime(now.year, now.month - i, 1);
        final label = formatter.format(targetMonth);
        double sum = 0;
        for (final exp in expenses) {
          if (exp.expenseType == 'Expense' &&
              exp.dateTime.year == targetMonth.year &&
              exp.dateTime.month == targetMonth.month) {
            sum += exp.amount;
          }
        }
        list.add(MonthlyBarData(label, sum, i == 0));
      }
    } else {
      // YEARLY: Last 4 years
      for (int i = 3; i >= 0; i--) {
        final targetYear = now.year - i;
        final label = targetYear.toString();
        double sum = 0;
        for (final exp in expenses) {
          if (exp.expenseType == 'Expense' && exp.dateTime.year == targetYear) {
            sum += exp.amount;
          }
        }
        list.add(MonthlyBarData(label, sum, i == 0));
      }
    }
    return list;
  }

  // Calculate dynamic totals for the selected period range
  PeriodTotals _calculatePeriodTotals(
      List<CreateExpenseModel> expenses, int periodIndex) {
    final now = DateTime.now();
    DateTime start;
    DateTime end = DateTime(now.year, now.month, now.day, 23, 59, 59);

    if (periodIndex == 0) {
      // Daily: Today
      start = DateTime(now.year, now.month, now.day);
    } else if (periodIndex == 1) {
      // Weekly: Current Monday to Sunday
      start = now.subtract(Duration(days: now.weekday - 1));
      start = DateTime(start.year, start.month, start.day);
    } else if (periodIndex == 2) {
      // Monthly: Current Month
      start = DateTime(now.year, now.month, 1);
    } else {
      // Yearly: Current Year
      start = DateTime(now.year, 1, 1);
    }

    double withdrawal = 0;
    double deposit = 0;

    for (final exp in expenses) {
      if (exp.dateTime.isAfter(start.subtract(const Duration(seconds: 1))) &&
          exp.dateTime.isBefore(end.add(const Duration(seconds: 1)))) {
        if (exp.expenseType == 'Expense') {
          withdrawal += exp.amount;
        } else if (exp.expenseType == 'Income') {
          deposit += exp.amount;
        }
      }
    }
    return PeriodTotals(withdrawal, deposit);
  }

  String _money(num v) => '₦${NumberFormat('#,##0').format(v)}';

  // Calculate top categories spent for the selected period
  List<CategorySpend> _calculatePeriodTopCategories(
      List<CreateExpenseModel> expenses, int periodIndex) {
    final now = DateTime.now();
    DateTime start;
    DateTime end = DateTime(now.year, now.month, now.day, 23, 59, 59);

    if (periodIndex == 0) {
      start = DateTime(now.year, now.month, now.day);
    } else if (periodIndex == 1) {
      start = now.subtract(Duration(days: now.weekday - 1));
      start = DateTime(start.year, start.month, start.day);
    } else if (periodIndex == 2) {
      start = DateTime(now.year, now.month, 1);
    } else {
      start = DateTime(now.year, 1, 1);
    }

    final Map<String, double> categorySums = {};
    for (final exp in expenses) {
      if (exp.expenseType == 'Expense' &&
          exp.dateTime.isAfter(start.subtract(const Duration(seconds: 1))) &&
          exp.dateTime.isBefore(end.add(const Duration(seconds: 1)))) {
        final cat =
            exp.expenseSubList == '..' ? 'General' : exp.expenseSubList;
        categorySums[cat] = (categorySums[cat] ?? 0) + exp.amount;
      }
    }
    final sorted = categorySums.entries
        .map((e) => CategorySpend(e.key, e.value))
        .toList()
      ..sort((a, b) => b.amount.compareTo(a.amount));
    return sorted;
  }

  Widget _categoryProgressBar(
      CategorySpend cat, double totalExpense, NeuColors neu) {
    final ratio =
        totalExpense > 0 ? (cat.amount / totalExpense).clamp(0.0, 1.0) : 0.0;
    Color barColor = neu.primary;
    final nameLower = cat.category.toLowerCase();
    if (nameLower.contains('grocer') ||
        nameLower.contains('food') ||
        nameLower.contains('house') ||
        nameLower.contains('general')) {
      barColor = neu.expense;
    } else if (nameLower.contains('transport') ||
        nameLower.contains('data') ||
        nameLower.contains('cloth')) {
      barColor = neu.debt;
    } else if (nameLower.contains('eat') || nameLower.contains('cafe')) {
      barColor = neu.primary;
    } else {
      barColor = neu.accent;
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
                  color: neu.textPrimary,
                  fontSize: 14.5.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                _money(cat.amount),
                style: TextStyle(
                  color: neu.textPrimary,
                  fontSize: 14.5.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Gap(0.8.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: 8,
              width: double.infinity,
              color: neu.shadowDark,
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: ratio,
                child: Container(color: barColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PeriodTotals {
  final double withdrawal;
  final double deposit;
  PeriodTotals(this.withdrawal, this.deposit);
}

class MonthlyBarData {
  final String label;
  final double value;
  final bool isActive;
  MonthlyBarData(this.label, this.value, this.isActive);
}

class CategorySpend {
  final String category;
  final double amount;
  CategorySpend(this.category, this.amount);
}
