import 'package:expense_app/model/create_expense.dart';
import 'package:expense_app/provider/item_provider.dart';
import 'package:expense_app/utils/colors.dart';
import 'package:expense_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icon.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:table_calendar/table_calendar.dart';

final selectedDayProvider = StateProvider<DateTime>((ref) => DateTime.now());
final calendarFormatProvider =
    StateProvider<CalendarFormat>((ref) => CalendarFormat.week);

class TransactionListView extends HookConsumerWidget {
  const TransactionListView({Key? key}) : super(key: key);
  Color getBorderColor(
      DateTime day, Set<DateTime> datesWithExpenses, Color defaultColor) {
    return datesWithExpenses.contains(day) ? AppColor.kBlueColor : defaultColor;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyProvider = ref.watch(itemBoxProvider);
    final selectedDay = ref.watch(selectedDayProvider);
    final calendarFormat = ref.watch(calendarFormatProvider);
    return historyProvider.when(
      skipLoadingOnReload: true,
      data: (data) {
        List<CreateExpenseModel> expenseData = data.values
            .where((expense) =>
                expense.dateTime.year == selectedDay.year &&
                expense.dateTime.month == selectedDay.month &&
                expense.dateTime.day == selectedDay.day)
            .toList();

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
                // eventLoader: (day) {
                //   List<DateTime> datesWithEvents = expenseData
                //       .where((expense) =>
                //           expense.dateTime.year == day.year &&
                //           expense.dateTime.month == day.month &&
                //           expense.dateTime.day == day.day)
                //       .map((expense) => DateTime(
                //             expense.dateTime.year,
                //             expense.dateTime.month,
                //             expense.dateTime.day,
                //           ))
                //       .toList();
                //   return datesWithEvents;
                // },

                // eventLoader: (day) {
                //   // if (expenseData.isNotEmpty) {
                //   //   return expenseData.map((e) => e.dateTime).toList();
                //   // } else {
                //   //   return expenseData.map((e) => e.dateTime).toList();
                //   // }
                //   bool hasEvents = expenseData.any((expense) =>
                //       expense.dateTime.year == day.year &&
                //       expense.dateTime.month == day.month &&
                //       expense.dateTime.day == day.day);
                //   return hasEvents ? [day] : [];
                // },
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
                      child: const Text('View All')),
                ],
              ),
              expenseData.isEmpty
                  ? const Expanded(
                      child: Center(
                          child: Text('You vent saved  any expense today yet')))
                  : Expanded(
                      child: CustomScrollView(
                        slivers: [
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              childCount: expenseData.length,
                              (context, index) {
                                var history = expenseData[index];
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
                                return ListTile(
                                  title: Row(
                                    children: [
                                      Text(
                                        '${history.expenseType}\tfor\t${history.name}',
                                        style: TextStyle(
                                            color: AppColor.kDarkGreyColor,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        history.explain,
                                        style: TextStyle(
                                            color: AppColor.kDarkGreyColor,
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        timeago.format(history.dateTime),
                                        style: TextStyle(
                                            color: AppColor.kGreyColor.shade500,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  leading: iconData,
                                  trailing: Text(
                                    history.amount.toString(),
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
            ],
          ),
        );
      },
      error: (_, __) => const Text('Something went wrong'),
      loading: () => const CircularProgressIndicator(color: Colors.red),
    );
  }
}
