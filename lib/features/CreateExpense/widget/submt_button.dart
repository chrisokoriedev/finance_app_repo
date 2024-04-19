import 'package:expense_app/features/CreateExpense/notifer.dart/create_expense_notifer.dart';
import 'package:expense_app/model/create_expense.dart';
import 'package:expense_app/utils/colors.dart';
import 'package:expense_app/utils/const.dart';
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(
            Size(double.maxFinite, 2.h),
          ),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: customBorderRadius(10))),
          backgroundColor: MaterialStateColor.resolveWith(
              (states) => const Color.fromARGB(255, 221, 111, 111))),
      onPressed: () {
        if (expenseTitleController.text.isNotEmpty &&
            expenseDescripritionController.text.isNotEmpty &&
            expenseDescripritionController.text.isNotEmpty) {
          var add = CreateExpenseModel(
              name: expenseAmountController.text,
              amount: double.parse(expenseAmountController.text),
              expenseType: chooseExpense,
              explain: expenseDescripritionController.text,
              dateTime: choosedDate,
              expenseSubList: chooseSubExpense);
          ref.read(createExpenseNotifierProvider.notifier).addExpense(add);
          expenseAmountController.clear();
          expenseDescripritionController.clear();
          expenseTitleController.clear();
        } else if (chooseExpense == 'Expense' && chooseSubExpense == '..') {
          SnackBar snackBar = SnackBar(
            backgroundColor: AppColor.kDarkGreyColor,
            content: Text(
              'Choose expense type',
              style: TextStyle(fontSize: 14.sp, color: AppColor.kWhitColor),
            ),
            showCloseIcon: true,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          SnackBar snackBar = SnackBar(
            backgroundColor: AppColor.kDarkGreyColor,
            content: Text(
              'Enter All Field',
              style: TextStyle(fontSize: 14.sp, color: AppColor.kWhitColor),
            ),
            showCloseIcon: true,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: Text(
        'Create',
        style: TextStyle(
            fontSize: 14.sp,
            color: AppColor.kWhitColor,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
