import 'package:expense_app/core/domain/cal.dart';
import 'package:expense_app/core/model/create_expense.dart';
import 'package:expense_app/core/provider/item_provider.dart';
import 'package:expense_app/core/theme/neu_theme.dart';
import 'package:expense_app/core/utils/const.dart';
import 'package:expense_app/core/utils/format_date.dart';
import 'package:expense_app/core/utils/string_app.dart';
import 'package:expense_app/core/utils/text.dart';
import 'package:expense_app/core/widgets/neu.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ViewExpensesTimeline extends HookConsumerWidget {
  const ViewExpensesTimeline({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final neu = context.neu;
    final historyProvider = ref.watch(cloudItemsProvider);
    return Scaffold(
      backgroundColor: neu.surface,
      appBar: AppBar(
        backgroundColor: neu.surface,
        elevation: 0,
        surfaceTintColor: neu.surface,
        iconTheme: IconThemeData(color: neu.textPrimary),
        title: TextWidget(
            text: AppString.viewTimeline,
            color: neu.textPrimary,
            fontSize: 17.sp,
            fontWeight: FontWeight.w500),
      ),
      body: historyProvider.when(
        skipLoadingOnReload: true,
        error: (_, __) => Center(
            child: TextWidget(
                text: 'Something went wrong',
                color: neu.textSecondary,
                fontSize: 14.sp)),
        loading: () =>
            Center(child: CircularProgressIndicator(color: neu.primary)),
        data: (data) {
          final expenseData = [...data]
            ..sort((a, b) => b.dateTime.compareTo(a.dateTime));
          if (expenseData.isEmpty) {
            return const Center(child: NoDataView());
          }
          final Map<DateTime, List<CreateExpenseModel>> grouped = {};
          for (final e in expenseData) {
            final d =
                DateTime(e.dateTime.year, e.dateTime.month, e.dateTime.day);
            grouped.putIfAbsent(d, () => []).add(e);
          }
          return ListView.builder(
            padding: EdgeInsets.fromLTRB(4.w, 1.h, 4.w, 3.h),
            itemCount: grouped.length,
            itemBuilder: (context, index) {
              final date = grouped.keys.elementAt(index);
              final items = grouped[date] ?? [];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
                    child: TextWidget(
                        text: formatDate(date),
                        color: neu.textSecondary,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  NeuCard(
                    radius: 18,
                    padding: EdgeInsets.symmetric(vertical: 0.6.h),
                    child: Column(
                      children: [
                        for (final history in items)
                          _row(context, ref, neu, history),
                      ],
                    ),
                  ),
                  SizedBox(height: 1.6.h),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _row(BuildContext context, WidgetRef ref, NeuColors neu,
      CreateExpenseModel history) {
    final Color catColor;
    final IconData catIcon;
    if (history.expenseType == 'Income') {
      catColor = neu.income;
      catIcon = Icons.south_west;
    } else if (history.expenseType == 'Expense') {
      catColor = neu.expense;
      catIcon = Icons.north_east;
    } else {
      catColor = neu.debt;
      catIcon = Icons.account_balance;
    }
    final sign = history.expenseType == 'Income' ? '+' : '-';
    final subtitle = history.expenseSubList != '..'
        ? history.expenseSubList
        : history.expenseType;
    return Dismissible(
      key: ObjectKey(history),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 4.w),
        child: Icon(Icons.delete_outline, color: neu.expense, size: 20.sp),
      ),
      confirmDismiss: (_) async {
        return await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: neu.surface,
                title: TextWidget(
                    text: 'Delete transaction?',
                    color: neu.textPrimary,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500),
                content: TextWidget(
                    text: 'This cannot be undone.',
                    color: neu.textSecondary,
                    fontSize: 13.sp),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: TextWidget(
                          text: 'Cancel',
                          color: neu.textSecondary,
                          fontSize: 14.sp)),
                  TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: TextWidget(
                          text: 'Delete',
                          color: neu.expense,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ) ??
            false;
      },
      onDismissed: (_) {
        final id = history.id;
        if (id != null) {
          ref.read(deleteExpenseProvider.notifier).state.deleteExpense(id);
        }
      },
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.2.h),
        leading: NeuIconWell(icon: catIcon, color: catColor, size: 42),
        title: TextWidget(
            text: history.name,
            color: neu.textPrimary,
            fontSize: 14.sp,
            maxLine: 1,
            fontWeight: FontWeight.w500),
        subtitle: TextWidget(
            text: subtitle,
            color: neu.textSecondary,
            fontSize: 12.sp,
            maxLine: 1),
        trailing: TextWidget(
            text: '$sign₦${NumberFormat('#,##0').format(history.amount)}',
            color: catColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
