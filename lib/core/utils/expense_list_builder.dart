import 'package:expense_app/core/domain/cal.dart';
import 'package:expense_app/core/model/create_expense.dart';
import 'package:expense_app/core/theme/neu_theme.dart';
import 'package:expense_app/core/utils/colors.dart';
import 'package:expense_app/core/utils/const.dart';
import 'package:expense_app/core/utils/text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:timeago/timeago.dart' as timeago;

class ExpenseListBuilder extends HookConsumerWidget {
  final List<CreateExpenseModel> data;
  final bool showDateTIme;
  final bool showTime;
  final int childCount;

  const ExpenseListBuilder({
    super.key,
    required this.data,
    this.showDateTIme = true,
    this.showTime = false,
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
          if (history.expenseType == "Income") {
            catColor = neu.income;
          } else if (history.expenseType == "Expense") {
            catColor = neu.expense;
          } else {
            catColor = neu.debt;
          }

          final IconData catIcon =
              _getCategoryIcon(history.expenseSubList, history.expenseType);

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
              leading: Container(
                width: 12.5.w,
                height: 12.5.w,
                decoration: BoxDecoration(
                  color: neu.surface,
                  borderRadius: BorderRadius.circular(13.sp),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(catIcon, color: catColor, size: 18.sp),
              ),
              title: TextWidget(
                  text: history.name,
                  color: neu.textPrimary,
                  fontSize: 14.5.sp,
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
                  fontSize: 14.5.sp,
                  fontWeight: FontWeight.w500),
            ),
          );
        },
      ),
    );
  }

  IconData _getCategoryIcon(String category, String type) {
    if (type == "Income") {
      return Icons.account_balance_wallet_outlined;
    }
    final catLower = category.toLowerCase();
    if (catLower.contains("grocer") || catLower.contains("shop")) {
      return Icons.shopping_cart_outlined;
    } else if (catLower.contains("transport") ||
        catLower.contains("gas") ||
        catLower.contains("fuel") ||
        catLower.contains("car")) {
      return Icons.local_gas_station_outlined;
    } else if (catLower.contains("eat") ||
        catLower.contains("cafe") ||
        catLower.contains("coffee") ||
        catLower.contains("restaurant") ||
        catLower.contains("food")) {
      return Icons.coffee_outlined;
    } else if (catLower.contains("house") || catLower.contains("rent")) {
      return Icons.home_outlined;
    } else if (catLower.contains("data") ||
        catLower.contains("wifi") ||
        catLower.contains("phone")) {
      return Icons.wifi;
    } else if (catLower.contains("cloth") || catLower.contains("dress")) {
      return Icons.checkroom_outlined;
    }

    if (type == "Expense") {
      return Icons.north_east;
    }
    return Icons.account_balance_outlined;
  }
}
