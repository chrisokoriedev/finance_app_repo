import 'package:expense_app/core/model/create_expense.dart';
import 'package:expense_app/core/provider/item_provider.dart';
import 'package:expense_app/core/theme/neu_theme.dart';
import 'package:expense_app/core/utils/expense_list_builder.dart';
import 'package:expense_app/core/utils/routes.dart';
import 'package:expense_app/core/widgets/neu.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

final selectedDayProvider =
    StateProvider.autoDispose<DateTime>((ref) => DateTime.now());

class TransactionListView extends HookConsumerWidget {
  final PageController pageController;

  const TransactionListView(this.pageController, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyProvider = ref.watch(cloudItemsProvider);
    final selectedDay = ref.watch(selectedDayProvider);
    final neu = context.neu;

    return PopScope(
      canPop: false,
      onPopInvoked: (value) => pageController.jumpToPage(0),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: historyProvider.when(
              skipLoadingOnReload: true,
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) => const Center(child: Text('Something went wrong')),
              data: (data) {
                var dataNew = data..sort((a, b) => b.dateTime.compareTo(a.dateTime));

                List<CreateExpenseModel> expenseData = dataNew.where((expense) {
                  return expense.dateTime.year == selectedDay.year &&
                      expense.dateTime.month == selectedDay.month &&
                      expense.dateTime.day == selectedDay.day;
                }).toList();

                final count = expenseData.length;
                final totalSum = expenseData.fold<double>(0.0, (prev, element) {
                  if (element.expenseType == 'Income') {
                    return prev + element.amount;
                  } else {
                    return prev - element.amount;
                  }
                });

                return Column(
                  children: [
                    Gap(1.5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Transactions',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context.push(AppRouter.viewAllExpenses),
                          child: Text(
                            'Timeline',
                            style: TextStyle(
                              color: neu.debt,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gap(2.h),
                    _buildWeekStrip(selectedDay, ref, neu, context),
                    Gap(2.5.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 14.sp),
                      decoration: BoxDecoration(
                        color: neu.surface,
                        borderRadius: BorderRadius.circular(16.sp),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${_formatDayHeader(selectedDay)} · $count transaction${count == 1 ? '' : 's'}',
                            style: TextStyle(
                              color: neu.textSecondary,
                              fontSize: 13.5.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            '${totalSum >= 0 ? '+' : '-'}₦${NumberFormat('#,##0').format(totalSum.abs())}',
                            style: TextStyle(
                              color: totalSum >= 0 ? neu.primary : neu.expense,
                              fontSize: 14.5.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(2.h),
                    Expanded(
                      child: expenseData.isEmpty
                          ? Center(
                              child: Text(
                                "No transactions recorded today",
                                style: TextStyle(
                                  fontSize: 14.5.sp,
                                  color: neu.textSecondary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          : CustomScrollView(
                              slivers: [
                                ExpenseListBuilder(
                                  data: expenseData,
                                  childCount: expenseData.length,
                                  showDateTIme: false,
                                  showTime: true,
                                ),
                              ],
                            ),
                    ),
                    Gap(2.h),
                    GestureDetector(
                      onTap: () => context.push(AppRouter.viewAllExpenses),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 14.sp),
                        margin: EdgeInsets.only(bottom: 12.h),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: neu.surface,
                          borderRadius: BorderRadius.circular(16.sp),
                          boxShadow: neu.raised,
                        ),
                        child: Text(
                          'View full timeline',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  List<DateTime> _getWeekDays(DateTime selectedDay) {
    DateTime start = selectedDay.subtract(Duration(days: selectedDay.weekday - 1));
    return List.generate(7, (i) => start.add(Duration(days: i)));
  }

  Widget _buildWeekStrip(DateTime selectedDay, WidgetRef ref, NeuColors neu, BuildContext context) {
    final days = _getWeekDays(selectedDay);
    final weekdays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(7, (index) {
        final day = days[index];
        final isSelected = day.year == selectedDay.year &&
            day.month == selectedDay.month &&
            day.day == selectedDay.day;

        return GestureDetector(
          onTap: () {
            ref.read(selectedDayProvider.notifier).state = day;
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 10.sp),
            decoration: isSelected
                ? BoxDecoration(
                    color: neu.primary,
                    borderRadius: BorderRadius.circular(14.sp),
                    boxShadow: [
                      BoxShadow(
                        color: neu.primary.withOpacity(0.35),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  )
                : null,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  weekdays[day.weekday - 1],
                  style: TextStyle(
                    color: isSelected ? Colors.black.withOpacity(0.6) : neu.textSecondary,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gap(0.4.h),
                Text(
                  day.day.toString(),
                  style: TextStyle(
                    color: isSelected ? Colors.black : Colors.white,
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  String _formatDayHeader(DateTime date) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${days[date.weekday - 1]} ${date.day}';
  }
}
