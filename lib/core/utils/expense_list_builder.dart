import 'package:expense_app/core/domain/cal.dart';
import 'package:expense_app/core/model/create_expense.dart';
import 'package:expense_app/core/theme/neu_theme.dart';
import 'package:expense_app/core/utils/colors.dart';
import 'package:expense_app/core/utils/const.dart';
import 'package:expense_app/core/utils/text.dart';
import 'package:expense_app/core/widgets/neu.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:timeago/timeago.dart' as timeago;

class ExpenseListBuilder extends HookConsumerWidget {
  final List<CreateExpenseModel> data;
  final bool showDateTIme;

  final int childCount;
  const ExpenseListBuilder({
    super.key,
    required this.data,
    this.showDateTIme = true,
    required this.childCount,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).colorScheme;

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: childCount,
        (context, index) {
          if (data.isEmpty) {
            return const NoDataView();
          }
          final neu = context.neu;
          var history = data[index];
          final Color catColor;
          final IconData catIcon;
          if (history.expenseType == "Income") {
            catColor = neu.income;
            catIcon = Icons.south_west;
          } else if (history.expenseType == "Expense") {
            catColor = neu.expense;
            catIcon = Icons.north_east;
          } else {
            catColor = neu.debt;
            catIcon = Icons.account_balance;
          }
          final sign = history.expenseType == "Income" ? '+' : '-';
          final subtitleText = (history.expenseSubList != '..'
                  ? history.expenseSubList
                  : history.expenseType) +
              (showDateTIme ? ' · ${timeago.format(history.dateTime)}' : '');
          return Dismissible(
            key: ObjectKey(history),
            background: Container(
              color: AppColor.kredColor,
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 16.0.sp),
                  child: Icon(
                    Icons.delete,
                    size: 18.sp,
                    color: AppColor.kWhitColor,
                  ),
                ),
              ),
            ),
            direction: DismissDirection.endToStart,
            confirmDismiss: (direction) async {
              bool confirm = await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  surfaceTintColor: AppColor.kBlackColor,
                  backgroundColor: theme.onPrimary,
                  title: TextWidget(
                      text: 'Confirm Delete',
                      color: theme.primary,
                      fontSize: 16.sp,
                      letterSpacing: 1.3,
                      fontWeight: FontWeight.w600),
                  content: TextWidget(
                      text: 'Are you sure you want to delete this item?',
                      color: theme.primary,
                      fontSize: 16.sp,
                      letterSpacing: 1.3,
                      fontWeight: FontWeight.w600),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text('Cancel',
                          style: TextStyle(
                              fontSize: 15.sp,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w600)),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: Text(
                        'Delete',
                        style: TextStyle(
                            fontSize: 15.sp,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              );
              return confirm;
            },
            onDismissed: (direction) {
              final documentId = history.id;
              if (documentId != null) {
                ref
                    .read(deleteExpenseProvider.notifier)
                    .state
                    .deleteExpense(documentId);
              }
            },
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.2.h),
              leading: NeuIconWell(icon: catIcon, color: catColor, size: 44),
              title: TextWidget(
                  text: history.name,
                  color: neu.textPrimary,
                  fontSize: 14.sp,
                  maxLine: 1,
                  fontWeight: FontWeight.w500),
              subtitle: TextWidget(
                  text: subtitleText,
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
        },
      ),
    );
  }
}
