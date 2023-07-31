import 'package:expense_app/model/create_expense.dart';
import 'package:hive/hive.dart';

final box = Hive.box<CreateExpenseModel>('data');

int total() {
  var historyList = box.values.toList();
  int grandTotal = 0;

  for (var i = 0; i < historyList.length; i++) {
    int amount = int.parse(historyList[i].amount);
    
    if (historyList[i].expenseType == 'Income') {
      grandTotal += amount;
    } else if (historyList[i].expenseType == 'Expense') {
      grandTotal -= amount;
    } else if (historyList[i].expenseType == 'Debt') {
      grandTotal -= amount;
    }
  }

  return grandTotal;
}
