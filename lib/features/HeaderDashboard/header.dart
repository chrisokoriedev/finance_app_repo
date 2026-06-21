import 'package:expense_app/core/domain/cal.dart';
import 'package:expense_app/core/model/create_expense.dart';
import 'package:expense_app/core/provider/firebase.dart';
import 'package:expense_app/core/provider/item_provider.dart';
import 'package:expense_app/core/theme/neu_theme.dart';
import 'package:expense_app/core/utils/const.dart';
import 'package:expense_app/core/utils/text.dart';
import 'package:expense_app/core/utils/user_avatar.dart';
import 'package:expense_app/core/widgets/neu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'controller/time_controller.dart';

class DashboardHeader extends ConsumerWidget {
  final PageController pageCntrl;
  const DashboardHeader(this.pageCntrl, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final neu = context.neu;
    final totals = ref.watch(totalsProvider);
    final cloud = ref.watch(cloudItemsProvider);
    final greeting = ref.watch(greetingProvider);
    final firebaseAuth = ref.watch(firebaseAuthProvider);

    return Padding(
      padding: EdgeInsets.fromLTRB(5.w, 2.h, 5.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hey ${getUserName()} 😊',
                    style: TextStyle(
                      color: neu.textSecondary,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Gap(0.4.h),
                  Row(
                    children: [
                      Text(
                        'nora',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gap(1.w),
                      Container(
                        width: 1.5.w,
                        height: 1.5.w,
                        decoration: BoxDecoration(
                          color: neu.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => pageCntrl.jumpToPage(3),
                child: Stack(
                  children: [
                    SizedBox(
                      width: 11.w,
                      height: 11.w,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: UserAvatar(firebaseAuth: firebaseAuth),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 2.2.w,
                        height: 2.2.w,
                        decoration: BoxDecoration(
                          color: neu.accent, // yellow/orange notification dot
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Gap(1.4.h),
          cloud.when(
            skipLoadingOnReload: true,
            data: (data) {
              final streak = _loggingStreak(data);
              final trendVal = _calculateMonthlyTrend(data);
              final totalSavings = totals.totalIncome - totals.totalExpense - totals.totalDebt;
              final ratio = totals.totalIncome > 0
                  ? (totalSavings / totals.totalIncome).clamp(0.0, 1.0)
                  : 0.0;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (streak > 0) ...[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 11.sp, vertical: 5.sp),
                      decoration: BoxDecoration(
                        color: neu.accent.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(20.sp),
                        border: Border.all(
                          color: neu.accent.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.local_fire_department, color: neu.accent, size: 14.sp),
                          Gap(1.5.w),
                          Text(
                            '$streak-day logging streak',
                            style: TextStyle(
                              color: neu.accent,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(1.2.h),
                  ],
                  _balanceCard(neu, totals, trendVal, ratio, context),
                  Gap(1.6.h),
                  Row(
                    children: [
                      _stat(neu, Icons.south_west, neu.income, 'Income',
                          totals.totalIncome),
                      Gap(2.5.w),
                      _stat(neu, Icons.north_east, neu.expense, 'Expense',
                          totals.totalExpense),
                      Gap(2.5.w),
                      _stat(Icons.monetization_on_outlined, neu.debt, 'Debt',
                          totals.totalDebt),
                    ],
                  ),
                  Gap(1.h),
                ],
              );
            },
            loading: () => Padding(
              padding: EdgeInsets.symmetric(vertical: 6.h),
              child:
                  Center(child: CircularProgressIndicator(color: neu.primary)),
            ),
            error: (error, stackTrace) => Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              child: TextWidget(
                  text: 'Could not load your data',
                  color: neu.textSecondary,
                  fontSize: 13.sp),
            ),
          ),
        ],
      ),
    );
  }

  double _calculateMonthlyTrend(List<CreateExpenseModel> expenses) {
    final now = DateTime.now();
    double trend = 0;
    for (final item in expenses) {
      if (item.dateTime.year == now.year && item.dateTime.month == now.month) {
        if (item.expenseType == 'Income') {
          trend += item.amount;
        } else {
          trend -= item.amount;
        }
      }
    }
    return trend;
  }

  Widget _balanceCard(NeuColors neu, Totals totals, double trendVal, double ratio, BuildContext context) {
    final onTrack = totals.grandTotal >= 0;
    final isPositiveTrend = trendVal >= 0;
    final trendColor = isPositiveTrend ? neu.primary : neu.expense;

    return Container(
      padding: EdgeInsets.all(18.sp),
      decoration: BoxDecoration(
        color: neu.surface,
        borderRadius: BorderRadius.circular(22.sp),
        boxShadow: neu.raised,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total balance',
                style: TextStyle(
                  color: neu.textSecondary,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 4.sp),
                decoration: BoxDecoration(
                  color: (onTrack ? neu.primary : neu.expense).withOpacity(0.08),
                  borderRadius: BorderRadius.circular(20.sp),
                  border: Border.all(
                    color: (onTrack ? neu.primary : neu.expense).withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      onTrack ? Icons.check_circle_outline : Icons.error_outline,
                      color: onTrack ? neu.primary : neu.expense,
                      size: 13.sp,
                    ),
                    Gap(1.w),
                    Text(
                      onTrack ? 'On track' : 'Over budget',
                      style: TextStyle(
                        color: onTrack ? neu.primary : neu.expense,
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Gap(0.5.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _money(totals.grandTotal),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Gap(0.8.h),
                    Row(
                      children: [
                        Icon(
                          isPositiveTrend ? Icons.north_east : Icons.south_west,
                          color: trendColor,
                          size: 13.sp,
                        ),
                        Gap(1.w),
                        Text(
                          '${isPositiveTrend ? '+' : '-'}₦${NumberFormat('#,##0').format(trendVal.abs())} this month',
                          style: TextStyle(
                            color: trendColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              _spentRing(neu, ratio),
            ],
          ),
        ],
      ),
    );
  }

  Widget _spentRing(NeuColors neu, double ratio) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 14.w,
          height: 14.w,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox.expand(
                child: CircularProgressIndicator(
                  value: ratio,
                  strokeWidth: 4.5,
                  strokeCap: StrokeCap.round,
                  backgroundColor: Colors.black.withOpacity(0.2),
                  valueColor: AlwaysStoppedAnimation(neu.accent),
                ),
              ),
              Text(
                '${(ratio * 100).round()}%',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Gap(0.6.h),
        Text(
          'goal',
          style: TextStyle(
            color: neu.textSecondary,
            fontSize: 11.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _stat(NeuColors neu, IconData icon, Color color, String label, double value) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 1.8.h, horizontal: 3.5.w),
        decoration: BoxDecoration(
          color: neu.surface,
          borderRadius: BorderRadius.circular(18.sp),
          boxShadow: neu.raised,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(7.sp),
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 16.sp),
            ),
            Gap(1.2.h),
            Text(
              label,
              style: TextStyle(
                color: neu.textSecondary,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            Gap(0.4.h),
            Text(
              _compact(value),
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _money(num v) => '₦${NumberFormat('#,##0').format(v)}';

  String _compact(num v) =>
      NumberFormat.compactCurrency(symbol: '₦', decimalDigits: 0).format(v);

  /// Consecutive days (ending today, or the most recent logged day) that have
  /// at least one recorded transaction.
  int _loggingStreak(List<CreateExpenseModel> data) {
    if (data.isEmpty) return 0;
    final days = data
        .map((e) => DateTime(e.dateTime.year, e.dateTime.month, e.dateTime.day))
        .toSet();
    final now = DateTime.now();
    var cursor = DateTime(now.year, now.month, now.day);
    if (!days.contains(cursor)) {
      cursor = cursor.subtract(const Duration(days: 1));
    }
    var streak = 0;
    while (days.contains(cursor)) {
      streak++;
      cursor = cursor.subtract(const Duration(days: 1));
    }
    return streak;
  }

  String _getGreetingText(Greeting greeting) {
    switch (greeting) {
      case Greeting.morning:
        return 'Good morning';
      case Greeting.afternoon:
        return 'Good afternoon';
      case Greeting.evening:
        return 'Good evening';
    }
  }
}
