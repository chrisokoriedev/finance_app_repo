import 'package:expense_app/core/provider/app_provider.dart';
import 'package:expense_app/core/model/create_expense.dart';
import 'package:expense_app/core/theme/neu_theme.dart';
import 'package:expense_app/core/utils/colors.dart';
import 'package:expense_app/core/widgets/neu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BuildCreateDataComponent extends ConsumerWidget {
  const BuildCreateDataComponent({
    super.key,
    required this.expenseTitleController,
    required this.expenseDescripritionController,
    required this.expenseAmountController,
    required this.chooseExpense,
    required this.choosedDate,
    required this.chooseSubExpense,
  });

  final TextEditingController expenseTitleController;
  final TextEditingController expenseDescripritionController;
  final TextEditingController expenseAmountController;
  final String chooseExpense;
  final String chooseSubExpense;
  final DateTime choosedDate;

  void _snack(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: AppColor.kDarkGreyColor,
      content: Text(message,
          style: TextStyle(fontSize: 14.sp, color: AppColor.kWhitColor)),
      showCloseIcon: true,
    ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final neu = context.neu;
    return SizedBox(
      width: double.infinity,
      child: NeuButton(
        filled: true,
        color: neu.primary,
        onTap: () {
          if (chooseExpense == 'Expense' && chooseSubExpense == '..') {
            _snack(context, 'Choose a category');
            return;
          }
          final amount = double.tryParse(expenseAmountController.text.trim());
          if (expenseTitleController.text.isNotEmpty &&
              expenseDescripritionController.text.isNotEmpty &&
              amount != null) {
            final add = CreateExpenseModel(
                name: expenseTitleController.text,
                amount: amount,
                expenseType: chooseExpense,
                explain: expenseDescripritionController.text,
                dateTime: choosedDate,
                expenseSubList: chooseSubExpense);
            ref.read(createExpenseNotifierProvider.notifier).addExpense(add);
            expenseAmountController.clear();
            expenseDescripritionController.clear();
            expenseTitleController.clear();
          } else {
            _snack(context, 'Please fill all fields');
          }
        },
        child: Text('Create transaction',
            style: TextStyle(
                fontSize: 14.sp,
                color: neu.surface,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
