import 'package:expense_app/core/domain/cal.dart';
import 'package:expense_app/core/model/create_expense.dart';
import 'package:expense_app/core/theme/neu_theme.dart';
import 'package:expense_app/core/utils/const.dart';
import 'package:expense_app/core/utils/text.dart';
import 'package:expense_app/core/widgets/neu.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:timeago/timeago.dart' as timeago;

class ExpenseListBuilder extends HookConsumerWidget {
  final List<CreateExpenseModel> data;
  final bool showDateTIme;
  final bool showTime;
  final int childCount;
  final double horizontalPadding;

  const ExpenseListBuilder({
    super.key,
    required this.data,
    this.showDateTIme = true,
    this.showTime = false,
    required this.childCount,
    this.horizontalPadding = 0.0,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          if (history.expenseType == "Income") {
            catColor = neu.income;
          } else if (history.expenseType == "Expense") {
            catColor = neu.expense;
          } else {
            catColor = neu.debt;
          }

          final IconData catIcon = getCategoryIcon(history.expenseSubList, history.expenseType);
          final sign = history.expenseType == "Income" ? '+' : '-';

          final String subtitleText;
          final categoryName = history.expenseSubList != '..'
              ? history.expenseSubList
              : history.expenseType;
          if (showTime) {
            subtitleText =
                '$categoryName · ${DateFormat.jm().format(history.dateTime).toLowerCase()}';
          } else if (showDateTIme) {
            subtitleText =
                '$categoryName · ${timeago.format(history.dateTime)}';
          } else {
            subtitleText = categoryName;
          }

          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 0.6.h,
            ),
            child: Dismissible(
              key: ObjectKey(history),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 5.w),
                decoration: BoxDecoration(
                  color: neu.expense.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(Icons.delete_outline, color: neu.expense, size: 20.sp),
              ),
              confirmDismiss: (direction) async {
                return await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: neu.surface,
                    title: TextWidget(
                      text: 'Delete transaction?',
                      color: neu.textPrimary,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    content: TextWidget(
                      text: 'This cannot be undone.',
                      color: neu.textSecondary,
                      fontSize: 13.sp,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: TextWidget(
                          text: 'Cancel',
                          color: neu.textSecondary,
                          fontSize: 14.sp,
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: TextWidget(
                          text: 'Delete',
                          color: neu.expense,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ) ?? false;
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
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
                decoration: BoxDecoration(
                  color: neu.surface,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: neu.raised,
                ),
                child: Row(
                  children: [
                    NeuIconWell(icon: catIcon, color: catColor, size: 42),
                    Gap(3.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            text: history.name,
                            color: neu.textPrimary,
                            fontSize: 14.5.sp,
                            maxLine: 1,
                            fontWeight: FontWeight.w500,
                          ),
                          Gap(0.4.h),
                          TextWidget(
                            text: subtitleText,
                            color: neu.textSecondary,
                            fontSize: 12.sp,
                            maxLine: 1,
                          ),
                        ],
                      ),
                    ),
                    Gap(2.w),
                    TextWidget(
                      text: '$sign₦${NumberFormat('#,##0').format(history.amount)}',
                      color: catColor,
                      fontSize: 14.5.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
