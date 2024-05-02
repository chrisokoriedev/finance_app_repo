import 'package:expense_app/model/create_expense.dart';
import 'package:expense_app/provider/item_provider.dart';
import 'package:expense_app/utils/colors.dart';
import 'package:expense_app/utils/expense_list_builder.dart';
import 'package:expense_app/utils/routes.dart';
import 'package:expense_app/utils/string_app.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:table_calendar/table_calendar.dart';

final selectedDayProvider =
    StateProvider.autoDispose<DateTime>((ref) => DateTime.now());
final calendarFormatProvider =
    StateProvider.autoDispose<CalendarFormat>((ref) => CalendarFormat.week);

class TransactionListView extends HookConsumerWidget {
  final PageController pageController;

  const TransactionListView(this.pageController, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyProvider = ref.watch(cloudItemsProvider);
    final selectedDay = ref.watch(selectedDayProvider);
    final calendarFormat = ref.watch(calendarFormatProvider);
    return PopScope(
      canPop: false,
      onPopInvoked: (value) => pageController.jumpToPage(0),
      child: historyProvider.when(
        skipLoadingOnReload: true,
        data: (data) {
          var dataNew = data..sort((a, b) => b.dateTime.compareTo(a.dateTime));

          List<CreateExpenseModel> expenseData = dataNew.where((expense) {
            return expense.dateTime.year == selectedDay.year &&
                expense.dateTime.month == selectedDay.month &&
                expense.dateTime.day == selectedDay.day;
          }).toList();

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 20.sp),
            child: Column(
              children: [
                TableCalendar(
                  focusedDay: selectedDay,
                  firstDay: DateTime.utc(2001, 10, 16),
                  lastDay: DateTime.utc(2060, 3, 14),
                  currentDay: selectedDay,
                  calendarFormat: calendarFormat,
                  availableCalendarFormats: const {
                    CalendarFormat.week: "Week",
                    CalendarFormat.twoWeeks: "Two Weeks",
                    CalendarFormat.month: "Month",
                  },
                  onFormatChanged: (onFormatChanged) {
                    if (onFormatChanged != calendarFormat) {
                      ref.read(calendarFormatProvider.notifier).state =
                          onFormatChanged;
                    }
                  },
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: true,
                  ),
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: AppColor.kBlackColor.withOpacity(0.8),
                      shape: BoxShape.circle,
                    ),
                    weekendTextStyle: const TextStyle(color: Colors.red),
                  ),
                  onDaySelected: (selectedDay, focusedDay) {
                    ref.read(selectedDayProvider.notifier).state = selectedDay;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap: () => context.push(AppRouter.viewAllExpenses),
                        child: Text(
                          AppString.viewTimeline,
                          style: TextStyle(fontSize: 14.sp, letterSpacing: 1.4),
                        )),
                  ],
                ),
                Expanded(
                    child: expenseData.isEmpty
                        ? Center(
                            child: Text('You vent saved  any expense today yet',
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600)))
                        : CustomScrollView(slivers: [
                            ExpenseListBuilder(
                                data: expenseData,
                                childCount: expenseData.length)
                          ]))
              ],
            ),
          );
        },
        error: (_, __) => const Text('Something went wrong'),
        loading: () => const CircularProgressIndicator(color: Colors.red),
      ),
    );
  }
}
