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
                  TextWidget(
                      text: _getGreetingText(greeting),
                      color: neu.textSecondary,
                      fontSize: 12.sp),
                  Gap(0.3.h),
                  TextWidget(
                      text: getUserName(),
                      color: neu.textPrimary,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500),
                ],
              ),
              GestureDetector(
                onTap: () => pageCntrl.jumpToPage(3),
                child: SizedBox(
                  width: 12.w,
                  height: 12.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: UserAvatar(firebaseAuth: firebaseAuth),
                  ),
                ),
              ),
            ],
          ),
          Gap(1.4.h),
          cloud.when(
            skipLoadingOnReload: true,
            data: (data) {
              final streak = _loggingStreak(data);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (streak > 1) ...[
                    NeuPill(
                        icon: Icons.local_fire_department,
                        label: '$streak-day logging streak',
                        color: neu.accent),
                    Gap(1.2.h),
                  ],
                  _balanceCard(neu, totals),
                  Gap(1.6.h),
                  Row(
                    children: [
                      _stat(neu, Icons.south_west, neu.income, 'Income',
                          totals.totalIncome),
                      Gap(2.5.w),
                      _stat(neu, Icons.north_east, neu.expense, 'Expense',
                          totals.totalExpense),
                      Gap(2.5.w),
                      _stat(neu, Icons.account_balance, neu.debt, 'Debt',
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

  Widget _balanceCard(NeuColors neu, Totals totals) {
    final ratio = totals.totalIncome > 0
        ? (totals.totalExpense / totals.totalIncome).clamp(0.0, 1.0)
        : 0.0;
    final onTrack = totals.grandTotal >= 0;
    return NeuCard(
      radius: 26,
      padding: EdgeInsets.all(5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                  text: 'Total balance',
                  color: neu.textSecondary,
                  fontSize: 12.sp),
              NeuPill(
                  icon: onTrack
                      ? Icons.check_circle_outline
                      : Icons.error_outline,
                  label: onTrack ? 'On track' : 'Over budget',
                  color: onTrack ? neu.primary : neu.expense),
            ],
          ),
          Gap(0.8.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: TextWidget(
                    text: _money(totals.grandTotal),
                    color: neu.textPrimary,
                    fontSize: 26.sp,
                    maxLine: 1,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w500),
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
                  strokeWidth: 5,
                  strokeCap: StrokeCap.round,
                  backgroundColor: neu.shadowDark,
                  valueColor: AlwaysStoppedAnimation(neu.accent),
                ),
              ),
              TextWidget(
                  text: '${(ratio * 100).round()}%',
                  color: neu.textPrimary,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500),
            ],
          ),
        ),
        Gap(0.3.h),
        TextWidget(text: 'spent', color: neu.textSecondary, fontSize: 10.sp),
      ],
    );
  }

  Widget _stat(
      NeuColors neu, IconData icon, Color color, String label, double value) {
    return Expanded(
      child: NeuCard(
        radius: 18,
        padding: EdgeInsets.symmetric(vertical: 1.6.h, horizontal: 2.w),
        child: Column(
          children: [
            NeuIconWell(icon: icon, color: color, size: 32, radius: 11),
            Gap(0.6.h),
            TextWidget(text: label, color: neu.textSecondary, fontSize: 11.sp),
            Gap(0.2.h),
            TextWidget(
                text: _compact(value),
                color: neu.textPrimary,
                fontSize: 13.sp,
                maxLine: 1,
                fontWeight: FontWeight.w500),
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
