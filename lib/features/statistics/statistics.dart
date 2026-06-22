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

final selectedPeriodTabProvider = StateProvider.autoDispose<int>((ref) => 1); // Daily, Weekly, Monthly
final selectedSubPeriodTabProvider = StateProvider.autoDispose<int>((ref) => 2); // D, W, M, Y

class Statistics extends ConsumerWidget {
  final PageController pageController;
  const Statistics(this.pageController, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final neu = context.neu;
    final itemProvider = ref.watch(cloudItemsProvider);
    final totals = ref.watch(totalsProvider);
    final selectedPeriodTab = ref.watch(selectedPeriodTabProvider);
    final selectedSubPeriodTab = ref.watch(selectedSubPeriodTabProvider);

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
                // Top Tab Selector (Daily, Weekly, Monthly)
                NeuSegmented(
                  segments: const ['Daily', 'Weekly', 'Monthly'],
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
                      padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 4.sp),
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
                Gap(2.h),
                // Sub-period selector (D, W, M, Y)
                NeuSegmented(
                  segments: const ['D', 'W', 'M', 'Y'],
                  selectedIndex: selectedSubPeriodTab,
                  activeColor: neu.primary,
                  onChanged: (index) {
                    ref.read(selectedSubPeriodTabProvider.notifier).state = index;
                  },
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
                    final barData = _calculateMonthlyBarData(data);

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
                                  majorGridLines: const MajorGridLines(width: 0),
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
                                  majorGridLines: const MajorGridLines(width: 0),
                                ),
                                series: <ColumnSeries<MonthlyBarData, String>>[
                                  ColumnSeries<MonthlyBarData, String>(
                                    dataSource: barData,
                                    xValueMapper: (MonthlyBarData d, _) => d.label,
                                    yValueMapper: (MonthlyBarData d, _) => d.value,
                                    pointColorMapper: (MonthlyBarData d, _) =>
                                        d.isActive ? neu.primary : neu.textSecondary.withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(8),
                                    width: 0.32,
                                    animationDuration: 600,
                                  ),
                                ],
                              ),
                            ),
                            Gap(3.h),
                            // Side-by-Side Withdrawal & Deposit Metrics
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(15.sp),
                                    decoration: BoxDecoration(
                                      color: neu.surface,
                                      borderRadius: BorderRadius.circular(18.sp),
                                      boxShadow: neu.raised,
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                color: neu.expense.withOpacity(0.12),
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
                                          text: _money(totals.totalExpense),
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
                                      borderRadius: BorderRadius.circular(18.sp),
                                      boxShadow: neu.raised,
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                color: neu.income.withOpacity(0.12),
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
                                          text: _money(totals.totalIncome),
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

  // Calculate actual expenses for the last 6 months ending with the current month
  List<MonthlyBarData> _calculateMonthlyBarData(List<CreateExpenseModel> expenses) {
    final now = DateTime.now();
    final List<MonthlyBarData> list = [];
    final formatter = DateFormat('MMM');

    for (int i = 5; i >= 0; i--) {
      final targetMonth = DateTime(now.year, now.month - i, 1);
      final monthLabel = formatter.format(targetMonth);

      double monthlySum = 0;
      for (final exp in expenses) {
        if (exp.expenseType == 'Expense' &&
            exp.dateTime.year == targetMonth.year &&
            exp.dateTime.month == targetMonth.month) {
          monthlySum += exp.amount;
        }
      }
      list.add(MonthlyBarData(monthLabel, monthlySum, i == 0));
    }
    return list;
  }

  String _money(num v) => '₦${NumberFormat('#,##0').format(v)}';
}

class MonthlyBarData {
  final String label;
  final double value;
  final bool isActive;
  MonthlyBarData(this.label, this.value, this.isActive);
}
