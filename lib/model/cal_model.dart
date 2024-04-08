import 'package:expense_app/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final totalProvider = StateNotifierProvider<TotalNotifier, Totals>((ref) {
  return TotalNotifier();
});

class Totals {
  final double totalExpense;
  final double totalIncome;
  final double totalDebt;

  const Totals(this.totalExpense, this.totalIncome, this.totalDebt);

  double get grandTotal => totalIncome - (totalExpense + totalDebt);
}

class TotalNotifier extends StateNotifier<Totals> {
  TotalNotifier() : super(const Totals(0, 0, 0));

  void calculateTotals() {
    double totalExpense = 0;
    double totalIncome = 0;
    double totalDebt = 0;

    for (var expense in boxUse.values) {
      double amount = expense.amount;
      debugPrint('Total Income: $totalIncome');

      if (expense.expenseType == 'Income') {
        totalIncome += amount;
      } else if (expense.expenseType == 'Expense') {
        totalExpense += amount;
      } else if (expense.expenseType == 'Debt') {
        totalDebt += amount;
      }
    }
    debugPrint('Total Income: $totalIncome');
    state = Totals(totalExpense, totalIncome, totalDebt);
  }
}
