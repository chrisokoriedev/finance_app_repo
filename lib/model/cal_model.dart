import 'package:expense_app/model/create_expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final box = Hive.box<CreateExpenseModel>('data');

@immutable
class Totals {
  final int totalExpense;
  final int totalIncome;
  final int totalDebt;

  const Totals(this.totalExpense, this.totalIncome, this.totalDebt);

  int get grandTotal => totalIncome - (totalExpense + totalDebt);
}



class TotalNotifier extends StateNotifier<Totals> {
  TotalNotifier() : super(const Totals(0, 0, 0));

  void calculateTotals() {
    var historyList = box.values.toList();
    int totalExpense = 0;
    int totalIncome = 0;
    int totalDebt = 0;

    for (var i = 0; i < historyList.length; i++) {
      int amount = int.parse(historyList[i].amount);

      if (historyList[i].expenseType == 'Income') {
        totalIncome += amount;
      } else if (historyList[i].expenseType == 'Expense') {
        totalExpense += amount;
      } else if (historyList[i].expenseType == 'Debt') {
        totalDebt += amount;
      }
    }
    state = Totals(totalExpense, totalIncome, totalDebt);
  }
}
