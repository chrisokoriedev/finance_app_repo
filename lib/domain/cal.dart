// ignore_for_file: unused_result, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_app/main.dart';
import 'package:expense_app/model/create_expense.dart';
import 'package:expense_app/provider/firebase.dart';
import 'package:expense_app/provider/item_provider.dart';
import 'package:expense_app/utils/string_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final totalProviderFuture = FutureProvider((ref) => TotalNotifier());

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
      if (expense.expenseType == 'Income') {
        totalIncome += amount;
      } else if (expense.expenseType == 'Expense') {
        totalExpense += amount;
      } else if (expense.expenseType == 'Debt') {
        totalDebt += amount;
      }
    }
    state = Totals(totalExpense, totalIncome, totalDebt);
  }
}

final addExpenseProvider = StateProvider((ref) => AddExpenseNotifer(
    ref, ref.read(firebaseAuthProvider), ref.read(fireStoreProvider)));

class AddExpenseNotifer {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  final Ref ref;
  AddExpenseNotifer(this.ref, this._firebaseAuth, this._firebaseFirestore);
  Future<void> addExpense(
      CreateExpenseModel expense, BuildContext context) async {
    try {
      final firestoreInstance = _firebaseFirestore;
      final userId = _firebaseAuth.currentUser!.uid;
      if (userId.isNotEmpty) {
        await firestoreInstance
            .collection(AppString.expense)
            .doc(userId)
            .collection(AppString.userExpense)
            .add({
          'name': expense.name,
          'amount': expense.amount,
          'expenseType': expense.expenseType,
          'explain': expense.explain,
          'dateTime': expense.dateTime.toIso8601String(),
          'expenseSubList': expense.expenseSubList,
        });
      }
      Navigator.pop(context);
      ref.refresh(totalProviderFuture);
      ref.refresh(cloudItemsProvider);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // Future<void> editExpense(
  //     CreateExpenseModel expense, BuildContext context) async {
  //   try {
  //     final box = await ref.watch(itemBoxProvider.future);
  //     await box.add(expense);
  //     Navigator.pop(context);
  //     ref.refresh(totalProviderFuture);
  //     ref.refresh(itemBoxProvider);
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }
}

final deleteExpenseProvider = StateProvider((ref) => DeleteExpense(
    ref, ref.read(firebaseAuthProvider), ref.read(fireStoreProvider)));

class DeleteExpense {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  final Ref ref;

  DeleteExpense(this.ref, this._firebaseAuth, this._firebaseFirestore);

  Future<void> deleteExpense(var expenseIndex) async {
    final firestoreInstance = _firebaseFirestore;
    final userId = _firebaseAuth.currentUser!.uid;
    var data = firestoreInstance
        .collection(AppString.expense)
        .doc(userId)
        .collection(AppString.userExpense)
        .doc(expenseIndex);
    try {
      await data.delete();
      debugPrint('Document deleted successfully!');
      ref.refresh(cloudItemsProvider.future);
      ref.refresh(totalProviderFuture);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
